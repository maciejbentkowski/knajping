class QuestionsController < ApplicationController
    load_and_authorize_resource

    def edit
        @question = Question.find(params[:id])
    end

    def destroy
        @question = Question.find(params[:id])
        @question.destroy!
    end

    private

    def current_ability
        @current_ability ||= QuestionAbility.new(current_user)
    end
end
