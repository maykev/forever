require 'rails_helper'

RSpec.describe ContactUsController, type: :controller do
    describe 'GET index' do
        render_views

        it 'renders the index template' do
            get :index
            expect(response.body).to match /Contact Us/im
        end
    end

    describe 'POST create' do
        def make_request(name: 'Tester', email: 'tester@example.com', message: 'test question')
            post :create, {name: name, email: email, message: message}
        end

        context 'all required fields are present' do
            it 'returns a 201' do
                make_request

                expect(response.status).to eq(201)
            end

            it 'sends an email' do
                contact_us_mailer = double()
                expect(Mailer).to receive(:contact_us_email).with('Tester', 'tester@example.com', 'test question').and_return(contact_us_mailer)
                expect(contact_us_mailer).to receive(:deliver_now)

                make_request
            end

            it 'create an email record' do
                expect(Email.count).to eq(0)

                make_request

                expect(Email.count).to eq(1)
                expect(Email.last.name).to eq('Tester')
                expect(Email.last.from).to eq('tester@example.com')
                expect(Email.last.message).to eq('test question')
            end
        end

        context 'a required field is missing' do
            context 'name is missing' do
                it 'returns a 400' do
                    make_request(name: nil)
                end
            end

            context 'email is missing' do
                it 'returns a 400' do
                    make_request(email: nil)
                end
            end

            context 'message is missing' do
                it 'returns a 400' do
                    make_request(message: nil)
                end
            end
        end
    end
end
