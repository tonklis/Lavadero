class FeedbacksController < ApiController

  def batch_create
    @feedbacks = Feedback.batch_create(params[:feedbacks])

    render json: @feedbacks
  end
end
