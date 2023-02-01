# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# frozen_string_literal: true

Movie.create(
  title: 'Interstellar',
  release_date: Date.parse('07 Nov 2014'),
  runtime: '169 min',
  genre: 'Adventure, Drama, Sci-Fi',
  parental_rating: 'PG-13',
  plot: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival."
)

Movie.create(
  title: 'Doctor Strange in the Multiverse of Madness',
  release_date: Date.parse('06 May 2022'),
  runtime: 'N/A',
  genre: 'Fantasy, Action, Adventure, Horror',
  parental_rating: 'N/A'
)

Movie.create(
  title: 'Avatar 2',
  release_date: Date.parse('16 December 2022'),
  runtime: 'N/A',
  genre: 'Action, Adventure, Science Fiction, Fantasy',
  parental_rating: 'N/A',
  plot: 'Twelve years after exploring Pandora and joining the Na’vi, Jake Sully has since raised a family with Neytiri and established himself within the clans of the new world. Of course, peace can only last so long. Especially when the military organization from the original film returns to “finish what they started”.'
)

1000.times do
  movie = Movie.create(
    title: Faker::Movie.title,
    release_date: Faker::Date.between(from: '2015-01-01', to: '2023-12-30'),
    runtime: "#{Faker::Number.between(from: 60, to: 150)} min",
    genre: %w[Action Science Fiction Fantasy Adventure Drama Sci-Fi].sample(3).join(', '),
    parental_rating: %w[N/A G PG PG-13 R NC-17].sample,
    plot: Faker::Lorem.paragraph
  )

  5.times do
    Rating.create(
      movie: movie,
      grade: [0, 1, 2, 3, 4, 5].sample
    )
  end
end
