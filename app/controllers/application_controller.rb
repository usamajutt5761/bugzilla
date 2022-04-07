class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?

 private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :email, :password, :current_password)}
    devise_parameter_sanitizer.permit( :sign_up, keys: [ :role])
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password)}
  end
end
