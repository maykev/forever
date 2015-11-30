require 'rails_helper'

RSpec.describe InvitationController, type: :routing do
    context 'GET index' do
        it 'routes to the invitation controller index action' do
            expect(get: '/invitation').to route_to(controller: 'invitation', action: 'index')
        end
    end

    context 'GET show' do
        it 'routes to the invitation controller show action' do
            expect(get: '/invitation/1').to route_to(controller: 'invitation', action: 'show', id: '1')
        end
    end

    context 'PUT update' do
        it 'routes to the invitation controller show action' do
            expect(put: '/invitation/1').to route_to(controller: 'invitation', action: 'update', id: '1')
        end
    end

    context 'GET thanks' do
        it 'routes to the invitation controller thanks action' do
            expect(get: '/invitation/thanks/1').to route_to(controller: 'invitation', action: 'thanks', id: '1')
        end
    end
end
