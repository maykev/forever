require 'rails_helper'

RSpec.describe EmmaController, type: :routing do
  it 'routes to the emma controller' do
    expect(get: '/emma').to route_to(controller: 'emma', action: 'index')
  end
end
