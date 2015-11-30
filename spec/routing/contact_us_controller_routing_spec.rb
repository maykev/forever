require 'rails_helper'

RSpec.describe ContactUsController, type: :routing do
  it 'routes to the main controller' do
    expect(get: '/contact_us').to route_to(controller: 'contact_us', action: 'index')
  end
end
