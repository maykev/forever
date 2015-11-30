require 'rails_helper'

RSpec.describe RsvpController, type: :controller do
  describe 'GET index' do
    render_views

    it 'renders the index template' do
      get :index
      expect(response.body).to match /R\.S\.V\.P/im
    end
  end
end
