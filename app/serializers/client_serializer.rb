class ClientSerializer < ActiveModel::Serializer
  attributes :id, :checkfront_id, :email, :name
end
