class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :answer_id, :order_id, :description
end
