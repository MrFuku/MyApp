FactoryBot.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    confirmed_at DateTime.now

    trait :admin do
      admin true
    end

    trait :non_active do
      confirmed_at nil
    end
  end
end
