require 'rails_helper'

RSpec.describe MainController, type: :controller do
  describe 'GET index' do
    render_views

    it 'renders the index template' do
      get :index
      expect(response.body).to match /FRIENDS FIRST/im
    end
  end
end
