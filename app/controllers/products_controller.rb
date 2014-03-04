class ProductsController < ApplicationController

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
    @product = Product.new(product_params)
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
    # params.require(:product).permit()
  end
end
