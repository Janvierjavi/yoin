FactoryBot.define do
  factory :user do
    name { "test_user_01" }
    email { "test_01@mail.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
