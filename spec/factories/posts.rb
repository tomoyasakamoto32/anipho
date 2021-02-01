FactoryBot.define do
  factory :post do
    title         {Faker::Lorem.sentence(10)}
    explanation   {Faker::Lorem.sentence}
    animal_name   {"sample"}
    category_id   { 2 }
    association :user

    after(:build) do |post|
      post.images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
