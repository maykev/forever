require 'rails_helper'

RSpec.describe RsvpController, type: :routing do
  it 'routes to the rsvp controller' do
    expect(get: '/rsvp').to route_to(controller: 'rsvp', action: 'index')
  end
end
