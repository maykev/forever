require 'rails_helper'

RSpec.describe Mailer, type: :mailer do
    describe '#contact_us_email' do
        let(:name) { 'Tester' }
        let(:email) { 'tester@example.com' }
        let(:message) { 'test message' }

        it 'send an email to the correct address' do
            expect(
                described_class.contact_us_email(name, email, message).to
            ).to eq(['amyandkevinswedding2016@gmail.com'])
        end

        it 'send an email from the correct address' do
            expect(
                described_class.contact_us_email(name, email, message).from
            ).to eq([email])
        end

        it 'sends an email with the correct subject' do
            expect(
                described_class.contact_us_email(name, email, message).subject
            ).to eq("Amy and Kevin's Wedding - Contact Us")
        end

        it 'sends an email with the correct body' do
            body = described_class.contact_us_email(name, email, message).body.encoded

            expect(body).to match(/Message sent from Amy & Kevin's Wedding Site/)
            expect(body).to match(/From: #{name} \(#{email}\)/)
            expect(body).to match(/#{message}/)
        end
    end
end
