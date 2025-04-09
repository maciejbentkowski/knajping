class QuestionsController < ApplicationController
    load_and_authorize_resource

    def edit
        @question = Question.find(params[:id])
    end
    

    def update
        @question = Question.find(params[:id])
        if @question.update(question_params)
            respond_to do |format|
                format.turbo_stream {
                    render turbo_stream: turbo_stream.replace(
                        helpers.dom_id(@question),
                        partial: "questions/question",
                        locals: {question: @question}
                    )
                }
            end

        else
        end
    end

    def destroy
        @question = Question.find(params[:id])
        @question.destroy!

        render turbo_stream: turbo_stream.remove(helpers.dom_id(@question))
    end

    private

    def current_ability
        @current_ability ||= QuestionAbility.new(current_user)
    end

    def question_params
        params.require(:question).permit(:body)
    end
end
