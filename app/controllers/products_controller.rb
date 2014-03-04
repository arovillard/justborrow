class ProductsController < ApplicationController
  before_filter :ensure_logged_in, :except => [:index,:show]
  def index
    @products = Product.all
  end

  def show
    @product = Product.find([:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = User.product.new(product_params)
    if @product.save
      redirect_to product_path(@product), notice: 'breakpoint created!'
    else
      render :new, notice: "something went wrong, please try again"
    end
  end

  def edit
    @product = Product.find([:id])
  end

  def update
    @product = Product.find([:id])
    if @product.update_attributes(product_params)
      redirect_to products_path(@product)
    end
  end

  def destroy
    @product = Product.find([:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:lender_id, :title, :description, :price)
  end
end
