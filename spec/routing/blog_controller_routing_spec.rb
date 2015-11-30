require 'rails_helper'

RSpec.describe BlogController, type: :routing do
  it 'routes to the blog controller' do
    expect(get: '/blog').to route_to(controller: 'blog', action: 'index')
  end
end
