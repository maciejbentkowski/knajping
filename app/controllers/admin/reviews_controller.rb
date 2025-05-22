class Admin::ReviewsController < AdminController
    def edit
        @review = Review.find(params[:id])
        render "admin/panel/reviews/edit"
    end


    def destroy
        @review = Review.find(params[:id])
        @review.destroy!

        render turbo_stream: turbo_stream.remove(helpers.dom_id(@review, "admin"))
    end
end
