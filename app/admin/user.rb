ActiveAdmin.register User do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  to_permit = [:email, :subscription_level, :is_admin,
    :sign_in_count, :created_at, :updated_at]

  permit_params to_permit

  index do
    # creates an appropriate column in the index view
    to_permit.each { |field| column field }
    # allows crud actions
    actions
  end

  form do |f|
    f.inputs "User details" do
      to_permit.each { |field| f.input field }
    end
    f.actions
  end


end
