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
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :username,:email, :password, :password_confirmation ,:role_type
form do |f|
    f.inputs do
      f.input :username  
      f.input :email
      f.input :role_type, as: :select, collection: (["buyer", "seller"])
      if f.object.new_record?
        f.inputs do
        f.input :password
        f.input :password
        f.input :password_confirmation
        end
    end
    end
    f.actions
  end
end
