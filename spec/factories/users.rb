FactoryBot.define do
  factory :user do
    name { "jiro" }
    email { "jiro@example.com" }
    password { "password" }
    confirmed_at DateTime.now
  end
end
