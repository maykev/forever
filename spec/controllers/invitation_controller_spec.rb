require 'rails_helper'

RSpec.describe InvitationController, type: :controller do
    let(:invitation) { create(:invitation) }
    let!(:invitee_1) { create(:invitee, invitation: invitation) }
    let!(:invitee_2) { create(:invitee, invitation: invitation) }

    describe 'GET index' do
        context 'the querystring contains an email' do
            context 'an email address that exists' do
                it 'returns a 200' do
                    get :index, {email: invitation.email}

                    expect(response.status).to eq(200)
                end

                it 'returns the invitation id' do
                    get :index, {email: invitation.email}

                    expect(response.body).to eq(invitation.id.to_s)
                end
            end

            context 'an email address that does not exist' do
                it 'returns a 404' do
                    get :index, {email: 'notinvited@example.com'}

                    expect(response.status).to eq(404)
                end
            end
        end

        context 'the querystring does not contain an email' do
            it 'returns a 404' do
                get :index

                expect(response.status).to eq(404)
            end
        end
    end

    describe 'GET show' do
        render_views

        context 'an invitation id that exists' do
            it 'returns a 200' do
                get :show, {id: invitation.id}

                expect(response.status).to eq(200)
            end

            it 'assigns the invitation' do
                get :show, {id: invitation.id}

                expect(assigns(@invitation)[:invitation]).to eq({
                                                                    id: invitation.id,
                                                                    name: invitation.name,
                                                                    invitees: [
                                                                        {
                                                                            id: invitee_1.id,
                                                                            name: invitee_1.name,
                                                                            accepted: invitee_1.accepted
                                                                        },
                                                                        {
                                                                            id: invitee_2.id,
                                                                            name: invitee_2.name,
                                                                            accepted: invitee_2.accepted
                                                                        }
                                                                    ]
                                                                })
            end

            it 'shows the invitation name and invitees' do
                get :show, {id: invitation.id}

                expect(response.body).to match /#{invitation.name}/im
                expect(response.body).to match /#{invitee_1.name}/im
                expect(response.body).to match /#{invitee_2.name}/im
            end
        end

        context 'an invitation id that does not exist' do
            it 'assigns invitation to nil' do
                get :show, {id: 999}

                expect(assigns(@invitation)[:invitation]).to be_nil
            end

            it 'show an invitation cannot be found message' do
                get :show, {id: 999}

                expect(response.body).to match /Invitation cannot be found/im
            end
        end
    end

    describe 'PUT update' do
        context 'an invitation id that exists' do
            it 'returns a 200' do
                put :update, {id: invitation.id, invitees: [
                    {
                        id: invitee_1.id
                    }
                ]}

                expect(response.status).to eq(200)
            end

            it 'set the invitation responded flag to true' do
                expect(invitation.responded).to eq(false)

                put :update, {id: invitation.id, invitees: [
                    {
                        id: invitee_1.id
                    }
                ]}

                expect(invitation.reload.responded).to eq(true)
            end

            it 'set the invitation responded date to now' do
                Timecop.freeze do
                    expect(invitation.response_date).to be_nil

                    put :update, {id: invitation.id, invitees: [
                        {
                            id: invitee_1.id
                        }
                    ]}

                    expect(invitation.reload.response_date).to eq(Time.now.utc)
                end
            end

            context 'an invitee accepted' do
                it 'sets the invitee accepted flag to true' do
                    expect(invitee_1.accepted).to be_nil

                    put :update, {id: invitation.id, invitees: [
                        {
                            id: invitee_1.id,
                            accepted: 'true'
                        }
                    ]}

                    expect(invitee_1.reload.accepted).to eq(true)
                end
            end

            context 'an invitee declined' do
                it 'sets the invitee accepted flag to false' do
                    expect(invitee_1.accepted).to be_nil

                    put :update, {id: invitation.id, invitees: [
                        {
                            id: invitee_1.id
                        }
                    ]}

                    expect(invitee_1.reload.accepted).to eq(false)
                end
            end

            context 'multiple invitees' do
                it 'sets the invitee accepted flags appropriately' do
                    expect(invitee_1.accepted).to be_nil
                    expect(invitee_2.accepted).to be_nil

                    put :update, {id: invitation.id, invitees: [
                        {
                            id: invitee_1.id,
                            accepted: 'true'
                        },
                        {
                            id: invitee_2.id
                        }
                    ]}

                    expect(invitee_1.reload.accepted).to eq(true)
                    expect(invitee_2.reload.accepted).to eq(false)
                end
            end
        end

        context 'an invitation id that does not exist' do
            it 'returns a 404' do
                put :update, {id: 999}

                expect(response.status).to eq(404)
            end
        end
    end

    describe 'GET thanks' do
        render_views

        context 'an invitation id that exists' do
            let!(:invitee_3) { create(:invitee, invitation: invitation) }

            it 'returns a 200' do
                get :thanks, {id: invitation.id}

                expect(response.status).to eq(200)
            end

            it 'assigns invitees' do
                invitee_1.update_attributes!(accepted: true)
                invitee_2.update_attributes!(accepted: true)
                invitee_3.update_attributes!(accepted: true)

                get :thanks, {id: invitation.id}

                expect(assigns(@invitees)[:invitees]).to eq([invitee_1.name, invitee_2.name, invitee_3.name])
            end

            context 'single invitee accepted' do
                let!(:invitee_2) { nil }
                let!(:invitee_3) { nil }

                it 'shows the invitee name' do
                    invitee_1.update_attributes!(accepted: true)

                    get :thanks, {id: invitation.id}

                    expect(response.body).to match /We look forward to seeing #{invitee_1.name} at the wedding/im
                end
            end

            context 'multiple invitees' do
                it 'shows the accepted invitee names' do
                    invitee_1.update_attributes!(accepted: true)
                    invitee_2.update_attributes!(accepted: true)
                    invitee_3.update_attributes!(accepted: true)

                    get :thanks, {id: invitation.id}

                    expect(response.body).to match /We look forward to seeing #{invitee_1.name}, #{invitee_2.name} and #{invitee_3.name} at the wedding/im
                end

                it 'does not show the declined invitee names' do
                    invitee_1.update_attributes!(accepted: true)
                    invitee_2.update_attributes!(accepted: true)
                    invitee_3.update_attributes!(accepted: false)

                    get :thanks, {id: invitation.id}

                    expect(response.body).to match /We look forward to seeing #{invitee_1.name} and #{invitee_2.name} at the wedding/im
                end
            end
        end

        context 'an invitation id that does not exist' do
            it 'assigns invitees to nil' do
                get :show, {id: 999}

                expect(assigns(@invitees)[:invitees]).to be_nil
            end

            it 'show an invitation cannot be found message' do
                get :thanks, {id: 999}

                expect(response.body).to match /Invitation cannot be found/im
            end
        end
    end
end
