require 'rails_helper'

RSpec.describe OurStoryController, type: :routing do
  it 'routes to the our story controller' do
    expect(get: '/our_story').to route_to(controller: 'our_story', action: 'index')
  end
end
