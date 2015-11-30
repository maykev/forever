require 'rails_helper'

RSpec.describe ContactUsController, type: :controller do
  describe 'GET index' do
    render_views

    it 'renders the index template' do
      get :index
      expect(response.body).to match /Contact Us/im
    end
  end
end
