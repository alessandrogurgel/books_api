FactoryBot.define do
  factory :book do
    sequence(:name) { |i| Faker::Book.title }
    sequence(:isbn) { |i| "123-321324356#{i}" }
    sequence(:authors) { |i| [Faker::Book.author] }
    country { 'Brazil' }
    number_of_pages {|i| Faker::Number.between(30, 500) }
    publisher {|i| Faker::Company.name }
    release_date {|i| Faker::Date.between(20.years.ago, Date.today) }
  end
end