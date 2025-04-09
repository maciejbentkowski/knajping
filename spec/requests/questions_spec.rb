require 'rails_helper'

RSpec.describe "Questions", type: :request do
    describe "DELETE /questions/:id" do
        context "when user owns the question" do
        let(:user) { create(:user) }
        let(:question) { create(:question, user: user) }
        it "removes a question" do
            sign_in(user)
            question
            expect do
            delete question_path(question)
            end.to change(Question, :count).by(-1)
        end
    end
end
end
