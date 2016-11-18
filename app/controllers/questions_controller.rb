class QuestionsController < ApiController

  def tree
    @questions = Question.where(root: true)

    render json: @questions
  end
end
