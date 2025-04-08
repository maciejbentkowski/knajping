class QuestionsController < ApplicationController

    def edit
        @question = Question.find(params[:id])
    end

    def destroy
        @question = Question.find(params[:id])
        @question.destroy!
    end
end
