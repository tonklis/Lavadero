class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :text, :parent_question_id, :child_question

  def child_question
    question_obj = {}
    if object.child_question
      question_obj[:id] = object.child_question.id
      question_obj[:text] = object.child_question.text
      question_obj[:question_type] = object.child_question.question_type
      question_obj[:required] = object.child_question.required
      question_obj[:child_answers] = ActiveModel::Serializer::CollectionSerializer.new(object.child_question.child_answers, each_serializer: AnswerSerializer)
    end
    question_obj
  end
end
