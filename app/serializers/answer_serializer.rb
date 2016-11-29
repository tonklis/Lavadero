class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :text, :parent_question_id, :child_questions

  def child_questions
    ActiveModel::Serializer::CollectionSerializer.new(object.child_questions, each_serializer: QuestionSerializer)
  end
end
