# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    release_date { Faker::Date.between(from: '2015-01-01', to: '2023-12-30') }
    runtime {"#{Faker::Number.between(from: 60, to: 150)} min" }
    genre {  %w[Action Science Fiction Fantasy Adventure Drama Sci-Fi].sample(3).join(', ') }
    parental_rating { %w[N/A G PG PG-13 R NC-17].sample }
    plot { "MyText" }
  end
end
