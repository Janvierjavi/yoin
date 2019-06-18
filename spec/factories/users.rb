FactoryBot.define do
  factory :user do
    name { "test_user_01" }
    email { "test_01@mail.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :user_second, class: User do
    name { "test_user_02" }
    email { "test_02@mail.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
