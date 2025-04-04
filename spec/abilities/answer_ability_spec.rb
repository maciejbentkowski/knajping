# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerAbility do
  subject(:ability) { described_class.new(user) }

  shared_examples "can read all answers" do
    it { is_expected.to be_able_to(:read, other_user_answer) }
  end

  let(:user) { nil }
  let(:other_user_answer) { create(:answer) }

  context 'when user is not logged in' do
    include_examples "can read all answers"

    it { is_expected.not_to be_able_to(:create, Answer) }
    it { is_expected.not_to be_able_to(:update, other_user_answer) }
    it { is_expected.not_to be_able_to(:destroy, other_user_answer) }
    it { is_expected.not_to be_able_to(:update, other_user_answer) }
    it { is_expected.not_to be_able_to(:destroy, other_user_answer) }
  end

  context 'when user is a regular user' do
    let(:user) { create(:user) }
    let(:own_answer) { create(:answer, user: user) }

    include_examples "can read all answers"

    context 'can create and then edit or update his own answers' do
      it { is_expected.to be_able_to(:create, Answer) }
      it { is_expected.to be_able_to(:edit, own_answer) }
      it { is_expected.to be_able_to(:update, own_answer) }
    end

    context 'cannot manage others answers' do
      it { is_expected.not_to be_able_to(:manage, other_user_answer) }
    end
  end

  context 'when user is a owner' do
    let (:user) { create(:owner) }

    include_examples "can read all answers"

    context 'cannot create and manage answers' do
      it { is_expected.not_to be_able_to(:create, Answer) }
    end

    context 'cannot manage others answers' do
        it { is_expected.not_to be_able_to(:manage, other_user_answer) }
      end
  end

  context 'when user is a moderator' do
    let(:user) { create(:moderator) }
    let(:own_answer) { create(:answer, user: user) }

    include_examples "can read all answers"

    context 'can create and manage any answer' do
        it { is_expected.to be_able_to(:create, Answer) }
        it { is_expected.to be_able_to(:manage, own_answer) }
        it { is_expected.to be_able_to(:manage, other_user_answer) }
    end
  end

  context 'when user is an admin' do
    let(:user) { create(:admin) }
    let(:own_answer) { create(:answer, user: user) }


    include_examples "can read all answers"

    context 'can create and manage any answer' do
        it { is_expected.to be_able_to(:create, Answer) }
        it { is_expected.to be_able_to(:manage, own_answer) }
        it { is_expected.to be_able_to(:manage, other_user_answer) }
    end
  end
end
