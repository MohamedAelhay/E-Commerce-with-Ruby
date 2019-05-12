class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html { redirect_to main_app.root_url, notice: exception.message }
        format.js   { head :forbidden, content_type: 'text/html' }
      end
    end

    def after_sign_in_path_for(resource)

      if current_admin_user
        admin_dashboard_path
      elsif current_user.role_type == "seller" 
        store_path(current_user.store.id)
      elsif current_user.role_type == "buyer"
        root_path
      else
        root_path
      end
    end

    def after_sign_up_path_for(resource)
      root_path
    end
    
    protected
    def configure_permitted_parameters
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :image) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
    end 
end
