FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name#{n}" }
    sequence(:email)  { |n| "name#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    telephone { "00011112222"}
    birth_date {Date.new(1990, 1, 1)}
    sequence(:uid) { |n| "123456789#{n}"}
    confirmed_at {Time.zone.now}
  end
end
