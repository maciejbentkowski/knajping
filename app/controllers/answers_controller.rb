class AnswersController < ApplicationController
    load_and_authorize_resource
    def create
        @question = Question.find(params[:question_id])
        @answer = @question.answers.new(answer_params.merge(user_id: current_user.id))

        if @answer.save
            respond_to do |format|
                format.turbo_stream {
                    render turbo_stream: turbo_stream.replace(
                        helpers.dom_id(@question),
                        partial: "questions/question",
                        locals: { question: @question }
                    )
                }
                format.html { redirect_to venue_path(@question.venue) }
            end
        else
            respond_to do |format|
                format.html { redirect_to venue_path(@venue), alert: "Could not create question" }
            end
        end
    end

    private
    def current_ability
        @current_ability ||= AnswerAbility.new(current_user)
    end

    def answer_params
        params.require(:answer).permit(:body)
    end
end
