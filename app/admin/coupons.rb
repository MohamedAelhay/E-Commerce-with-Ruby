ActiveAdmin.register Coupon do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 #permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
# Never trust parameters from the scary internet, only allow the white list through.

permit_params :code,:expiration_date,:usage_number,:discount_type,:discount_amount
form do |f|
    f.inputs do
      f.input :code
      f.input :expiration_date
      f.input :usage_number
      f.input :discount_type , as: :select, collection: (["persentage", "fixed"])
      f.input :discount_amount,allow_blank: false
      
    end
    f.actions
  end
# def coupon_params
#     params.require(:coupon).permit(:code, :expiration_date, :usage_number, :discount_type, :discount_amount)
#   end
#end
end
