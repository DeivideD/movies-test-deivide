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
    describe '.by_year' do
      let!(:movie_1) { create(:movie, release_date: Date.parse("06 May 2022")) }

      it { expect(described_class.by_year(2022)).to match_array([movie_1]) }
    end
  end
end
