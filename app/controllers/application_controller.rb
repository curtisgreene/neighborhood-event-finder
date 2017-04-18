class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :logged_in_user

  private

    def current_user
      @user ||= User.find(session[:user_id])
    end

    def logged_in?
      session[:user_id].present?
    end

    def logged_in_user
    unless logged_in?
       flash[:notice] = "Please log in."
       redirect_to login_path
    end
 end

end
