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
            it "Return 302" do
                get new_venue_path
                expect(response).to have_http_status(302)
            end

            it "Redirect to login_path" do
                get new_venue_path
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

            it "Return 302" do
                sign_in(user)
                get new_venue_path
                expect(response).to have_http_status(302)
            end

            it "Redirect to root path" do
                get new_venue_path
                sign_in(user)
                get new_venue_path
                expect(response).to redirect_to(root_path)
            end
        end
    end
end
