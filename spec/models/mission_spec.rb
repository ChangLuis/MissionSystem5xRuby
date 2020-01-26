require 'rails_helper'

RSpec.describe Mission, type: :model do
  describe 'Validation' do
    let(:mission) { build(:mission1) }

    context 'Title' do
      it 'Presence of title' do
        is_expected.to validate_presence_of(:title)
      end

      it 'Length of title' do
        is_expected.to validate_length_of(:title).is_at_most(10)
      end
    end

    it 'Presence of contents' do
      is_expected.to validate_presence_of(:contents)
    end

    it 'Presence of status' do
      is_expected.to validate_presence_of(:status)
    end

    it 'Presence of priority_order' do
      is_expected.to validate_presence_of(:priority_order)
    end

    it 'Presence of initial_time_at' do
      is_expected.to validate_presence_of(:initial_time_at)
    end

    it 'Presence of finish_time_at' do
      is_expected.to validate_presence_of(:finish_time_at)
    end
  end
end
