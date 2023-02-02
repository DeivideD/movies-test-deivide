# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :ratings }
  end

  describe 'validations' do
    %i[title release_date].each do |param|
      it { is_expected.to validate_presence_of param }
    end
  end

  context 'scopes' do
    describe '.by_release_date' do
      let!(:movie_1) { create(:movie, release_date: Date.parse("06 May 2022")) }
      let!(:movie_2) { create(:movie, release_date: Date.parse("01 Jan 2023")) }
      let!(:movie_3) { create(:movie, release_date: Date.parse("15 Jan 2023")) }

      it { expect(described_class.by_release_date).to eq({ 2022.0 => 1, 2023.0 => 2 }) }
    end

    describe '.by_year' do
      let!(:movie_1) { create(:movie, release_date: Date.parse("06 May 2022")) }

      it { expect(described_class.by_year(2022)).to match_array([movie_1]) }
    end
  end

  context 'calculate rate' do
    describe '.calculate_rating' do
      let!(:movie) { create(:movie) }
      let!(:date) { create(:rating, movie: movie, grade: 5) }

      it { expect(described_class.last.rating).to eq(5) }
    end
  end
end
