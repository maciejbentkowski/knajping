class QuestionsController < ApplicationController

    def edit
        @question = Question.find(params[:id])
    end
end
