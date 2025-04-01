require 'rails_helper'

RSpec.describe "Venues", type: :request do
    describe "GET /venues" do
        it "Return 200" do
            get venues_path
            expect(response).to have_http_status(200)
        end
    end
    describe "GET /venues/:id" do
        let(:venue) { create(:venue) }

        it "Return 200" do
            get venue_path(venue)
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /venues/new" do
        context "User not logged in" do
            it "Return 302 and redirect to login_path" do
                get new_venue_path
                expect(response).to have_http_status(302)
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "Owner user logged in" do
            let(:user) { create(:owner) }

            it "Return 200" do
                sign_in(user)
                get new_venue_path
                expect(response).to have_http_status(200)
            end
        end
        context "Reviewer user logged in" do
            let(:user) { create(:user) }

            it "Return 302 and redirect to root path" do
                sign_in(user)
                get new_venue_path
                expect(response).to have_http_status(302)
                expect(response).to redirect_to(root_path)
            end
        end
    end

    describe "POST /venues" do
        context "with valid params" do 
            let(:user) { create :owner }
            it "creates a new venue" do 
                sign_in(user)
                params = {
                    venue: {
                        name: "Sample name",
                        city: "Warsaw",
                        address: "Sample Street 1",
                        user: user
                    }
                }
                expect do
                    post venues_path, params: params
                end.to change(Venue, :count).by (1)
            end
        end
    end


    describe "DELETE /venues/:id" do
            context "when user owns the venue" do
            let(:user) { create(:owner) }
            let(:venue) { create(:venue, user: user) }
            it "removes a venue and redirects to index" do
                sign_in(user)
                venue
                expect do
                delete venue_path(venue)
                end.to change(Venue, :count).by(-1)

                expect(response).to redirect_to(venues_path)
                expect(flash[:notice]).to include("successfully deleted")
            end
        end
    end
end
