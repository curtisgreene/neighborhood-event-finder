class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :logged_in_user, :borough_names, :borough_name, :readable_time

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

    def borough_names(borough_array)
      borough_array.collect do |name|
        case name
          when "Mn"
            "Manhattan"
          when "Qn"
            "Queens"
          when "SI"
            "Staten Island"
          when "Bk"
            "Brooklyn"
          when "Bx"
            "Bronx"
        end
      end.join(", ")
    end

    def borough_name(name) #for user generated borough info, ie, not in an array
      case name
        when "Mn"
          "Manhattan"
        when "Qn"
          "Queens"
        when "SI"
          "Staten Island"
        when "Bk"
          "Brooklyn"
        when "Bx"
          "Bronx"
      end
    end

    def readable_time(time)
      time.strftime("%A, %B %d %I:%M %p")
    end

end
