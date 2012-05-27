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

class User < ActiveRecord::Base
  attr_accessible :email, :name
  
  # Regular expression to match emails with a valid format. 
    # \A          : match start of a string
    # [\w+\-.]+   : at least one word character, plus, hyphen, or dot
    # [a-z\d\-.]+ : at least one letter, digit, hyphen or dot
    # [a-z]+      : at least one letter
    # \z          : match end of a string
    # i           : case insensitive
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  :presence => true,
                    :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format => { :with => email_regex},
                    :uniqueness => { :case_sensitive => false }
end
