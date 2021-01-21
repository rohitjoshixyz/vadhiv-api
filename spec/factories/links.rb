FactoryBot.define do
    factory :link do
      title { Faker::Lorem.word }
      url { Faker::Internet.url(host: title) }
    end
  end