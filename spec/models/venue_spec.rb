require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
