ActiveAdmin.register WallRole do

  to_permit = [:user_id, :wall_id, :created_at, :updated_at]

  permit_params to_permit

  index do
    to_permit.each { |field| column field }
    actions
  end
end
