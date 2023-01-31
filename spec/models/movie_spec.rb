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
end
