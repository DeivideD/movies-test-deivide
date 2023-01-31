# frozen_string_literal: true

FactoryBot.define do
  factory :rating do
    movie
    grade { "" }
  end
end
