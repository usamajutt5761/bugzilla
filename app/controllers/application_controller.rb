class ApplicationController < ActionController::Base



  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?

 protected

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
