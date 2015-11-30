require 'rails_helper'

RSpec.describe MainController, type: :routing do
  it 'routes to the main controller' do
    expect(get: '/').to route_to(controller: 'main', action: 'index')
  end
end
