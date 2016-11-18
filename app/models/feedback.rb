class Feedback < ApplicationRecord
  belongs_to :order
  belongs_to :answer
end
