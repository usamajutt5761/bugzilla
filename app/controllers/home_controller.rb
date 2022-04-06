class  HomeController < ApplicationController

  # before_action :authenticate_user!
  ## if you want spesific action for require authentication
  ## before_filter :authenticate_user!, :only => [:action1, :action2]
  def index
    @users=User.all
    if not user_signed_in?  
      redirect_to user_session_path, notice: 'login to continue'
    end
  end
end