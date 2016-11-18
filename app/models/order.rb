class Order < ApplicationRecord
  belongs_to :client
  has_many :answers, through: :feedbacks
end
