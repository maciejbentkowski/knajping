require 'rails_helper'
RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:venue) }
    it { should have_one(:rating).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:rating) }
  end

  describe 'avg_rating' do
    let(:review) { create(:review) }

    it 'has avg_rating set after creation' do
      expect(review.avg_rating).not_to be_nil
    end
  end

  describe 'scopes' do
    describe '.recent' do
      let!(:old_review) { create(:review, created_at: 2.days.ago) }
      let!(:new_review) { create(:review, created_at: 1.day.ago) }

      it 'returns reviews in descending order by creation date' do
        expect(Review.recent_3.first).to eq(new_review)
      end

      it 'limits the result to 3 reviews' do
        create_list(:review, 15)
        expect(Review.recent_3.count).to eq(3)
      end
    end
  end

  describe 'avg_rating' do
    context 'when all ratings are 5' do
      let(:review) { create(:review, :with_rating_five) }

      it 'has all individual ratings equal to 5' do
        expect(review.rating.atmosphere_rating).to eq(5)
        expect(review.rating.availability_rating).to eq(5)
        expect(review.rating.quality_rating).to eq(5)
        expect(review.rating.service_rating).to eq(5)
        expect(review.rating.uniqueness_rating).to eq(5)
        expect(review.rating.value_rating).to eq(5)
      end

      it 'returns average rating of 5.0' do
        expect(review.avg_rating).to eq(5.0)
      end
    end
  end
end
