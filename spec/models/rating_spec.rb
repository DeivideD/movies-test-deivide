require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :movie }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :movie }

    it 'grade cannnot be less than 0' do
      rating = FactoryBot.build(:rating, grade: -1)
      expect(rating.valid?).to eq false
    end

    it 'grade cannnot be more than 5' do
      rating = FactoryBot.build(:rating, grade: 6)
      expect(rating.valid?).to eq false
    end
  end

  context 'calculate rate' do
    describe '.calculate_rating' do
      let!(:movie) { create(:movie) }
      let!(:date) { create(:rating, movie: movie, grade: 5) }

      it { expect(movie.rating).to eq(5) }
    end
  end
end
