class Feedback < ApplicationRecord
  belongs_to :order
  belongs_to :answer

  def self.batch_create feedbacks

    feedback_array = []

    feedbacks.each do |feedback|
      feedback_array << Feedback.create!(order_id: feedback[:order_id], answer_id: feedback[:answer_id], description: feedback[:description])
    end

    return feedback_array

  end

end
