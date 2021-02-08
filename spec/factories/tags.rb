FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.sentence(10) }
  end
end
