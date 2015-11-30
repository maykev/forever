require 'rails_helper'

RSpec.describe LocationController, type: :controller do
  describe 'GET index' do
    render_views

    it 'renders the index template' do
      get :index
      expect(response.body).to match /Location/im
    end
  end
end