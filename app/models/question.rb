class Question < ApplicationRecord
  has_many :child_answers, class_name: 'Answer', foreign_key: 'parent_question_id'
  has_and_belongs_to_many :parent_answers, class_name: 'Answer'

   QUESTION_TYPES = [
    'RATE',
    'SINGLE',
    'MULTIPLE'
  ]
  
  validates :question_type, inclusion: {in: QUESTION_TYPES}

  
end
