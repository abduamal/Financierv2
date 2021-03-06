class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authorize
    #this makes methods available in views
    helper_method :current_user
    helper_method :logged_in?

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !current_user.nil?
    end
    #this forces users to log in before viewing certain pages
    def authorize
        redirect_to '/' unless logged_in?
    end
end
