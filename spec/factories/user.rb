FactoryBot.define do
  factory :user do
    nickname              {"test"}
    email                 {"test@example"}
    password              {"111aaa"}
    password_confirmation {password}
  end
end