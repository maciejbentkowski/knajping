RSpec.describe Rating, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:atmosphere_rating) }
    it { should validate_presence_of(:availability_rating) }
    it { should validate_presence_of(:quality_rating) }
    it { should validate_presence_of(:service_rating) }
    it { should validate_presence_of(:uniqueness_rating) }
    it { should validate_presence_of(:value_rating) }

    let(:valid_rating_range) { 1..6 }
    [ :atmosphere_rating, :availability_rating, :quality_rating,
     :service_rating, :uniqueness_rating, :value_rating ].each do |rating_field|
      it { should validate_inclusion_of(rating_field).in_range(valid_rating_range) }
    end
  end

  describe 'callbacks' do
    describe '#update_review_avg_rating' do
      let(:review) { create(:review) }
      let(:rating) { review.rating }

      it 'updates review avg_rating when rating changes' do
        old_avg = rating.review.avg_rating
        rating.update(atmosphere_rating: 3)
        expect(rating.review.reload.avg_rating).not_to eq(old_avg)
      end

      it 'calculates correct average after multiple rating changes' do
        rating.update(atmosphere_rating: 2, service_rating: 3)

        expected_avg = [
          rating.atmosphere_rating = 2, # atmosphere rating changed
          rating.availability_rating,
          rating.quality_rating,
          rating.service_rating = 3, # service rating changed
          rating.uniqueness_rating,
          rating.value_rating
        ].sum.to_f / 6

        expect(rating.review.reload.avg_rating).to eq(expected_avg.round(2))
      end
    end
  end

  describe '#avg_rating' do
    let(:rating) { build(:rating) }

    it 'calculates average of all ratings' do
      ratings = [
        rating.atmosphere_rating,
        rating.availability_rating,
        rating.quality_rating,
        rating.service_rating,
        rating.uniqueness_rating,
        rating.value_rating
      ]

      expected_avg = (ratings.sum.to_f / ratings.size).round(2)
      expect(rating.send(:avg_rating)).to eq(expected_avg)
    end
  end
end
