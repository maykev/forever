require 'rails_helper'

RSpec.describe LocationController, type: :routing do
  it 'routes to the location controller' do
    expect(get: '/location').to route_to(controller: 'location', action: 'index')
  end
end
