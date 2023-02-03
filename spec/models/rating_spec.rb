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

    describe '.average_rate_last_two_months' do
      let!(:movie) { create(:movie) }
      let!(:movie2) { create(:movie) }
      let!(:rating) { create(:rating, movie: movie, grade: 5) }
      let!(:rating2) { create(:rating, movie: movie, grade: 3) }

      it { expect(described_class.average_rate_last_two_months).to eq(4) }
    end

    describe '.calculate_rating' do
      let!(:movie) { create(:movie) }
      let!(:rating) { create(:rating, movie: movie, grade: 5) }

      it { expect(movie.rating).to eq(5) }
    end
  end

end
