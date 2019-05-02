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
controller do
def coupon_params
    params.require(:coupon).permit(:code, :expiration_date, :usage_number, :discount_type, :discount_amount)
  end
end
end
