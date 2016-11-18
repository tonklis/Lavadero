class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :text, :parent_question_id, :child_question

  def child_question
    ActiveModelSerializers::SerializableResource.new(object.child_question, {})
  end
end
