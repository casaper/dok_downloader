FactoryBot.define do
  factory :download do
    source
    target_dir
    user
    url { 'MyString' }
    added_at { Faker::Time.between(from: 2.days.ago, to: 1.minute.ago) }
    title { 'MyString' }
    description { 'MyText' }
  end
end
