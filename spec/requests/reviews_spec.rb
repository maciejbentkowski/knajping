require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  describe "GET /reviews" do
    it "Return 200" do
        get reviews_path
        expect(response).to have_http_status(200)
    end
  end
  describe "GET /reviews/:id" do
    let(:review) { create(:review) }

    it "Return 200" do
        get review_path(review)
        expect(response).to have_http_status(200)
    end
  end

  describe "GET /reviews/new" do
    let(:venue) { create(:venue) }

    context "User not logged in" do
      it "Return 302 and redirect to login_path" do
          get new_venue_review_path(venue)
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "Owner user logged in" do
      let(:user) { create(:owner) }
      it "Return 302 and redirect to root path" do
          sign_in(user)
          get new_venue_review_path(venue)
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(root_path)
      end
    end
    context "Reviewer user logged in" do
      let(:user) { create(:user) }

      it "Return 200" do
          sign_in(user)
          get new_venue_review_path(venue)
          expect(response).to have_http_status(200)
      end
    end
  end
  describe "POST /reviews" do
    context "with valid params" do
        let(:user) { create :user }
        let(:venue) { create :venue }
        it "creates a new review" do
            sign_in(user)
            params = {
                review: {
                    content: "Sample content",
                    venue_id: venue,
                    user_id: user
                }
            }
            expect do
                post venue_reviews_path(venue), params: params
            end.to change(Review, :count).by (1)
        end
    end
  end
end
