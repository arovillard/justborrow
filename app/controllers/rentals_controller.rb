class RentalsController < ApplicationController
  before_filter :load_product
  before_filter :ensure_logged_in

  def new
    # add_breadcrumb 'new rental', new_product_rental_path
  end

  def create
    @rental = @product.rentals.new(rental_params)
    if @rental.save
      redirect_to product_path(@product), notice: 'rental created!'
    else
      redirect_to product_path(@product), notice: "something went wrong"
    end
  end

  def show
    # add_breadcrumb 'product rentals', product_rental_path
  end

  def edit
    # add_breadcrumb 'edit rental', edit_product_rental_path
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.update(rental_params)
      redirect_to user_path(current_user)
    else
      render "edit"
    end
end

 def update_rental
    @request = Rental.find(params[:request_id])
    @request.update_attributes!(:rental_approved => true)
  end

  private
  def rental_params
    params.require(:rental).permit(:borrower_id, :product_id, :start_date, :end_date, :rental_detail, :rental_approved, :borrower_acceptance)
  end

  def load_product
    @product = Product.find(params[:product_id])
  end

end
