require 'rails_helper'

RSpec.describe BlogController, type: :controller do
    describe 'GET index' do
        render_views

        let!(:blog_1) { create(:blog) }
        let!(:blog_2) { create(:blog) }

        it 'assigns blogs' do
            get :index

            expect(assigns(@blogs)[:blogs]).to eq([blog_1, blog_2])
        end

        it 'shows all the blog entries' do
            get :index

            expect(response.body).to match /#{blog_1.date}/im
            expect(response.body).to match /#{blog_1.entry}/im

            expect(response.body).to match /#{blog_2.date}/im
            expect(response.body).to match /#{blog_2.entry}/im
        end
    end
end
