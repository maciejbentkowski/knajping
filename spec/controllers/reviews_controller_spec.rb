require "rails_helper"

RSpec.describe ReviewsController, type: :controller do
    describe "GET #show" do
      let(:review) { create(:review) }
      it "has a 200 status code" do
        get :show, params: { id: review.id }
        expect(response.status).to eq(200)
      end
    end
end
