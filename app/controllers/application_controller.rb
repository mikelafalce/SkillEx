class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :this_user, :logged_in?

  def this_user
    @this_user ||= User.find_by_id(session[:user])
  end

  def logged_in?
   this_user != nil
  end
end
