# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :name, :password, :password_confirmation
  
  has_many :microposts, :dependent => :destroy
  has_many :relationships,  :dependent => :destroy,
                            :foreign_key => "follower_id"
  has_many :reverse_relationships,  :dependent => :destroy, 
                                    :foreign_key => "followed_id",
                                    :class_name => "Relationship" 
  has_many :following,  :through => :relationships, :source => :followed 
  has_many :followers,  :through => :reverse_relationships,
                        :source => :follower
  
  # Regular expression to match emails with a valid format. 
    # \A          : match start of a string
    # [\w+\-.]+   : at least one word character, plus, hyphen, or dot
    # [a-z\d\-.]+ : at least one letter, digit, hyphen or dot
    # [a-z]+      : at least one letter
    # \z          : match end of a string
    # i           : case insensitive
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  :presence   => true,
                    :length     => { :maximum => 50 }
  validates :email, :presence   => true,
                    :format     => { :with => email_regex},
                    :uniqueness => { :case_sensitive => false }

  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence      => true,
                       :confirmation  => true,
                       :length => { :within => 6..40 }
  
  before_save :encrypt_password
  
  def feed
    Micropost.from_users_followed_by(self)
  end
  
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end
  
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  
  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  class << self
    # ------------------------------------------------------------
    # 'authenticate' is a class method. We could've equivalently used: 
    # 1.  def User.authenticate(email, submitted_password)...end, or
    # 2.  class << self
    #       def authenticate(email, submitted_password)...end
    #     end
    # ------------------------------------------------------------
    # The 'authenticate' method using the ternary operator:
    def authenticate(email, submitted_password)
      user = find_by_email(email)
      (user && user.has_password?(submitted_password)) ? user : nil
    end
  
    def authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil 
    end
  end 
  
  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
