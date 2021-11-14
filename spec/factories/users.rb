FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    nickname { Faker::Lorem.characters(number: 10) }
    telephone_number { Faker::Lorem.characters(number: 20) }
    postal_code { Faker::Lorem.characters(number: 7) }
    address { Faker::Lorem.characters(number: 20) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end