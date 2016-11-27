class Feedback < ApplicationRecord
  belongs_to :order
  belongs_to :answer

  def self.batch_create feedbacks

    feedback_array = []

    feedbacks.each do |feedback|
      order = Order.find_by_checkfront_id(feedback[:order_checkfront_id])
      if not order
        order = Order.create!(checkfront_id: feedback[:order_checkfront_id])
      end
      feedback_array << Feedback.create!(order_id: order.id, answer_id: feedback[:answer_id], description: feedback[:description])
    end

    return feedback_array

  end

end
