class RentalsController < ApplicationController
  before_filter :load_product, only: [:index, :create, :new]
  before_filter :ensure_logged_in


  def create
    check_availability
    if @available == "yes"
      @rental = @product.rentals.new(rental_params)
      if @rental.save
        flash[:notice] = "Your rental request has been sent, check your transactions for status update"
        redirect_to product_path(@product)
      else
        render "edit"
      end
    else
      flash[:notice] = "The item is not available for the selecte period of time, please choose different dates"
      redirect_to product_path(@product)
    end
  end

  def show
    @rental = Rental.find(params[:id])
    @messages = @rental.messages.sort_by(&:created_at).reverse
    # add_breadcrumb 'product rentals', product_rental_path
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.update(rental_params)
      redirect_to user_path(current_user)
    else
      render "edit"
    end
  end

  private
  def rental_params
    params.require(:rental).permit(:borrower_id, :product_id, :start_date, :end_date, :rental_detail, :rental_approved, :borrower_acceptance)
  end

  def load_product
    @product = Product.find(params[:product_id])
  end

end
