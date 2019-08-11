FactoryBot.define do
  #allows us to run code 'FactoryBot.create(:user)' elsewhere in RSPEC.
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com" 
    end
    password { 'secretPassword' }
    password_confirmation { 'secretPassword' }
  end

  factory :gram do
    message { "hello" }
    association :user
  end
end