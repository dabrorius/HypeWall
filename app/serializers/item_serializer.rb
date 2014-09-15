class ItemSerializer < ActiveModel::Serializer
  attributes :id
  has_one :wall
end
