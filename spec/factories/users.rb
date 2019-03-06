FactoryBot.define do
  factory :user do
    name { "jiro" }
    email { "jiro@example.com" }
    password { "password" }
    confirmed_at DateTime.now
  end

  factory :valid_user, class: User do
    name { "taro" }
    email { "taro@example.com" }
    password { "password" }
  end

  factory :invalid_user, class: User do
    name { "" }
    email { "" }
    password { "" }
  end
end
