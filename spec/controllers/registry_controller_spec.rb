require 'rails_helper'

RSpec.describe RegistryController, type: :controller do
  describe 'GET index' do
    render_views

    it 'renders the index template' do
      get :index
      expect(response.body).to match /Registry/im
    end
  end
end
