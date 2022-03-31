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
    devise_parameter_sanitizer.permit( :sign_up, keys: [ :role])
   #  devise_parameter_sanitizer.permit( :sign_up, keys: [:avatar])
   #  devise_parameter_sanitizer.permit( :account_update, keys: [ :avatar])
 end


#  protected
#  def authenticate_user!
#    if user_signed_in?
#      super
#    else
#      redirect_to user_session_path, :notice => 'login to continue'
#      ## if you want render 404 page
#      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
#    end
#  end

end
