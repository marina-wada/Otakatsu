FactoryBot.define do
  factory :item do
    item_user_id { Faker::Lorem.characters(number: 20) }
    genre_id { Faker::Lorem.characters(number: 20) }
    ask_item1 { Faker::Lorem.characters(number: 20) }
    ask_item2 { Faker::Lorem.characters(number: 20) }
    ask_item3 { Faker::Lorem.characters(number: 20) }
    ask_item4 { Faker::Lorem.characters(number: 20) }
    ask_item5 { Faker::Lorem.characters(number: 20) }
    character { Faker::Lorem.characters(number: 20) }
    kind { Faker::Lorem.characters(number: 20) }
    introduction { Faker::Lorem.characters(number: 30) }
    item_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/22280591.jpg')) }
    exchanged_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/22196032.jpg')) }
  end
end