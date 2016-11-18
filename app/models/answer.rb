class Answer < ApplicationRecord
  has_many :orders, through: :feedbacks
  belongs_to :parent_question, class_name: 'Question', foreign_key: 'parent_question_id'
  belongs_to :child_question, class_name: 'Question', foreign_key: 'child_question_id'
end
