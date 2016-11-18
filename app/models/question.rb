class Question < ApplicationRecord
  has_many :child_answers, class_name: 'Answer', foreign_key: 'parent_question_id'
  has_many :parent_answers, class_name: 'Answer', foreign_key: 'child_question_id'

   QUESTION_TYPES = [
    'RATE',
    'SINGLE',
    'MULTIPLE'
  ]
  
  validates :question_type, inclusion: {in: QUESTION_TYPES}

  
end
