require 'rails_helper'

RSpec.describe Invitation, type: :model do
  let(:invitation) { create(:invitation) }

  describe 'associations' do
    it 'should have many invitees' do
      expect(subject).to have_many(:invitees)
    end
  end

  describe 'validations' do
    it 'should validate the presence of email' do
      expect(subject).to validate_presence_of(:email)
    end

    it 'should validate the presence of email' do
      expect(subject).to validate_presence_of(:name)
    end

    it 'should validate the uniqueness of email' do
      invitation.update_attributes!(name: 'Test')

      expect(subject).to validate_uniqueness_of(:email)
    end
  end
end
