class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_breadcrumb "home", :root_path


  def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in."
      redirect_to new_session_path
    end
  end

  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end
end
