FactoryBot.define do
  factory :user do
    password { 'asdfasdfasdf' }
    email { Faker::Internet.unique.email }
  end
end
