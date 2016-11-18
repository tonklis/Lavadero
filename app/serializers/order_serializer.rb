class OrderSerializer < ActiveModel::Serializer
  attributes :id, :checkfront_id, :client_id
end
