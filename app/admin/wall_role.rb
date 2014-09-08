ActiveAdmin.register WallRole do

  to_permit = [:user_id, :wall_id, :created_at, :updated_at]

  permit_params to_permit

  index do
    # creates an appropriate column in the index view
    to_permit.each { |field| column field }
    # allows crud actions
    actions
  end

  # form do |f|
  #   f.inputs "Wall role details" do
  #     # f.select :user_id
  #     # f.select :wall_id
  #     # f.input :created_at
  #     # f.input :updated_at
  #     to_permit.each { |field| f.input field }
  #   end
  #   f.actions
  # end


end
