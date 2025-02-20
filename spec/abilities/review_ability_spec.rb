# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewAbility do
  subject(:ability) { described_class.new(user) }

  shared_examples "can read all reviews" do
    it { is_expected.to be_able_to(:read, other_user_review) }
  end

  let(:user) { nil }
  let(:other_user_review) {create(:review)}

  context 'when user is not logged in' do
    include_examples "can read all reviews"

    it { is_expected.not_to be_able_to(:create, Review) }
    it { is_expected.not_to be_able_to(:update, other_user_review) }
    it { is_expected.not_to be_able_to(:destroy, other_user_review) }
    it { is_expected.not_to be_able_to(:update, other_user_review) }
    it { is_expected.not_to be_able_to(:destroy, other_user_review) }
  end

  context 'when user is a regular user' do
    let(:user) { create(:user) }
    let(:own_review) {create(:review, user: user)}

    include_examples "can read all reviews"

    context 'can create and then edit or update his own reviews' do
      it { is_expected.to be_able_to(:create, Review) }
      it { is_expected.to be_able_to(:edit, own_review)}
      it { is_expected.to be_able_to(:update, own_review)}
    end

    context 'cannot manage others venues' do
      it { is_expected.not_to be_able_to(:manage, other_user_review) }
    end
  end

  context 'when user is a owner' do
    let (:user) { create(:owner) }

    include_examples "can read all reviews"

    context 'cannot create and manage reviews' do
      it { is_expected.not_to be_able_to(:create, Review) }
    end

    context 'cannot manage others venues' do
        it { is_expected.not_to be_able_to(:manage, other_user_review) }
      end
  end

  context 'when user is a moderator' do
    let(:user) { create(:moderator) }
    let(:own_review) {create(:review, user: user)}

    include_examples "can read all reviews"

    context 'can create and manage any Review' do
        it { is_expected.to be_able_to(:create, Review) }
        it { is_expected.to be_able_to(:manage, own_review)}
        it { is_expected.to be_able_to(:manage, other_user_review)}
    end
  end

  context 'when user is an admin' do
    let(:user) { create(:admin) }
    let(:own_review) {create(:review, user: user)}


    include_examples "can read all reviews"

    context 'can create and manage any Review' do
        it { is_expected.to be_able_to(:create, Review) }
        it { is_expected.to be_able_to(:manage, own_review)}
        it { is_expected.to be_able_to(:manage, other_user_review)}
    end
  end
end
