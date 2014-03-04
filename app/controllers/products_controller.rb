class ProductsController < ApplicationController
  before_filter :ensure_logged_in, :except => [:index,:show]
  before_filter :find_product, :only => [:show, :edit, :update, :destroy]
  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to product_path(@product), notice: 'breakpoint created!'
    else
      render :new, notice: "something went wrong, please try again"
    end
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to products_path(@product)
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:lender_id, :title, :description, :price)
  end
end
