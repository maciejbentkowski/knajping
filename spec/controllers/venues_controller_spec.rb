require "rails_helper"

RSpec.describe VenuesController, type: :controller do
    describe "GET #index" do
        it "has a 200 status code" do
          get :index
          expect(response.status).to eq(200)
        end
    end

    describe "GET #show" do
      let(:venue) { create(:venue) }
      it "has a 200 status code" do
        get :show, params: { id: venue.id }
        expect(response.status).to eq(200)
      end
    end
end
