FactoryBot.define do
  factory :post do
    title         {"test"}
    explanation   {Faker::Lorem.sentence}
    animal_name   {"sample"}
    category_id   { 2 }
    association :user

    after(:build) do |post|
      post.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end