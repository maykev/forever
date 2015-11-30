require 'rails_helper'

RSpec.describe Invitee, type: :model do
  let(:invitee) { create(:invitee) }

  describe 'associations' do
    it 'should belong to an invitation' do
      expect(subject).to belong_to(:invitation)
    end
  end

  describe 'validations' do
    it 'should validate the presence of name' do
      expect(subject).to validate_presence_of(:name)
    end
  end
end
