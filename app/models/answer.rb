class Answer < ApplicationRecord
  has_many :orders, through: :feedbacks
  belongs_to :parent_question, class_name: 'Question', foreign_key: 'parent_question_id'
  has_and_belongs_to_many :child_questions, class_name: 'Question'
end
