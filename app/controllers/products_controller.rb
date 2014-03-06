class ProductsController < ApplicationController
  before_filter :ensure_logged_in, :except => [:index,:show]
  before_filter :find_product, :only => [:show, :edit, :update, :destroy]

  def index
    @products = Product.all

    add_breadcrumb "Products", products_path
  end

  def show
    @rental = Rental.new
    @product = Product.find(params[:id])
    add_breadcrumb 'products', product_path
  end

  def new
    @product = Product.new
    @category = Category.new
    @categories = Category.all
    add_breadcrumb 'new product', new_product_path
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      redirect_to product_path(@product), notice: 'Product created!'
    else
      render :new, notice: "something went wrong, please try again"
    end
  end

  def edit
    add_breadcrumb 'edit product', edit_product_path
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
    params.require(:product).permit(:lender_id, :title, :description, :price, :tag_list, :category_id)
  end
end
