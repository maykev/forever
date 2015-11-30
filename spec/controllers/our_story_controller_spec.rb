require 'rails_helper'

RSpec.describe OurStoryController, type: :controller do
  describe 'GET index' do
    render_views

    it 'renders the index template' do
      get :index
      expect(response.body).to match /Our Story/im
    end
  end
end
