class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def user_is_admin?
    unless current_user.admin?
      redirect_to root_url, :alert => "You are not authorized for that."
    end
  end
  helper_method :user_is_admin?

end
