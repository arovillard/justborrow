class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_breadcrumb "home", :root_path
  helper_method :check_availability

  def check_availability
    request_start_date = params[:rental][:start_date]
    request_end_date = params[:rental][:end_date]
    @available = "yes"
    @product.rentals.each do |reservation|
      if ((request_start_date >= reservation.start_date) && (request_start_date <= reservation.end_date)) || ((request_end_date >= reservation.start_date) && (request_end_date <= reservation.end_date)) || ((request_start_date < reservation.end_date) && (request_end_date > reservation.start_date))
        @available = "no"
        break
      end
    end
    @available
  end


  def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in."
      redirect_to new_session_path
    end
  end

  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end

  def location
    if params[:location].blank?
      if Rails.env.test? || Rails.env.development?
        @location ||= Geocoder.search("205.211.168.1").first
      else
        @location ||= request.location
      end
    else
      params[:location].each {|l| l = l.to_i } if params[:location].is_a? Array
      @location ||= Geocoder.search(params[:location]).first
      @location
    end
  end
end
