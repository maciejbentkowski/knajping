# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionAbility do
  subject(:ability) { described_class.new(user) }

  shared_examples "can read all questions" do
    it { is_expected.to be_able_to(:read, other_user_question) }
  end

  let(:user) { nil }
  let(:other_user_question) { create(:question) }

  context 'when user is not logged in' do
    include_examples "can read all questions"

    it { is_expected.not_to be_able_to(:create, Question) }
    it { is_expected.not_to be_able_to(:update, other_user_question) }
    it { is_expected.not_to be_able_to(:destroy, other_user_question) }
    it { is_expected.not_to be_able_to(:update, other_user_question) }
    it { is_expected.not_to be_able_to(:destroy, other_user_question) }
  end

  context 'when user is a regular user' do
    let(:user) { create(:user) }
    let(:own_question) { create(:question, user: user) }

    include_examples "can read all questions"

    context 'can create and then edit or update his own questions' do
      it { is_expected.to be_able_to(:create, Question) }
      it { is_expected.to be_able_to(:edit, own_question) }
      it { is_expected.to be_able_to(:update, own_question) }
      it { is_expected.to be_able_to(:destroy, own_question) }
    end

    context 'cannot manage others questions' do
      it { is_expected.not_to be_able_to(:manage, other_user_question) }
    end
  end

  context 'when user is a owner' do
    let (:user) { create(:owner) }
    let(:own_question) { create(:question, user: user) }

    include_examples "can read all questions"

    context 'can create and manage own questions' do
      it { is_expected.to be_able_to(:create, Question) }
      it { is_expected.to be_able_to(:edit, own_question) }
      it { is_expected.to be_able_to(:update, own_question) }
      it { is_expected.to be_able_to(:destroy, own_question) }
    end

    context 'cannot manage others questions' do
        it { is_expected.not_to be_able_to(:manage, other_user_question) }
      end
  end

  context 'when user is a moderator' do
    let(:user) { create(:moderator) }
    let(:own_question) { create(:question, user: user) }

    include_examples "can read all questions"

    context 'can create and manage any question' do
        it { is_expected.to be_able_to(:create, Question) }
        it { is_expected.to be_able_to(:manage, own_question) }
        it { is_expected.to be_able_to(:manage, other_user_question) }
    end
  end

  context 'when user is an admin' do
    let(:user) { create(:admin) }
    let(:own_question) { create(:question, user: user) }


    include_examples "can read all questions"

    context 'can create and manage any question' do
        it { is_expected.to be_able_to(:create, Question) }
        it { is_expected.to be_able_to(:manage, own_question) }
        it { is_expected.to be_able_to(:manage, other_user_question) }
    end
  end
end
