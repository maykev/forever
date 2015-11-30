require 'rails_helper'

RSpec.describe RegistryController, type: :routing do
  it 'routes to the registry controller' do
    expect(get: '/registry').to route_to(controller: 'registry', action: 'index')
  end
end
