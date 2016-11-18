class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :text, :question_type, :required, :child_answers

  def child_answers
    ActiveModel::Serializer::CollectionSerializer.new(object.child_answers, each_serializer: AnswerSerializer)
  end
end
