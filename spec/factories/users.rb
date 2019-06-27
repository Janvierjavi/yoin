FactoryBot.define do
  factory :user do
    name { "user1" }
    email { "test_01@mail.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :user_second, class: User do
    name { "user2" }
    email { "test_02@mail.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :user_third, class: User do
    name { "user3" }
    email { "test_03@mail.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
