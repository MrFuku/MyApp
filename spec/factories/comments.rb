FactoryBot.define do
  factory :comment do
    micropost { nil }
    user { nil }
    content { "MyText" }
  end
end
