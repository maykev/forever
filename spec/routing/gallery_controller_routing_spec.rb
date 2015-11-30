require 'rails_helper'

RSpec.describe GalleryController, type: :routing do
  it 'routes to the gallery controller' do
    expect(get: '/gallery').to route_to(controller: 'gallery', action: 'index')
  end
end
