ActiveAdmin.register Store do
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
permit_params :user_id,:name,:summary
form do |f|
    f.inputs do
      f.input :user_id , as: :select,:collection => User.get_sellers,include_blank: true,
      allow_blank: false
      f.input :name
      f.input :summary
      
    end
    f.actions
  end
controller do

def store_params
    params.require(:store).permit(:user_id, :name, :summary)
  end
end  
end
