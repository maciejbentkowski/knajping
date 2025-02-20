require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "associations" do
    it { should belong_to(:venue) }
    it { should belong_to(:user) }
end
end
