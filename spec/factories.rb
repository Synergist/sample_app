# By using the symbol ':user', we get Factory Girl to simulate the User model.
FactoryGirl.define do
  
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password               "foobar"
    password_confirmation  "foobar"
  end
  
  factory :micropost do
    user
    content "Lorem ipsum"
  end
end

