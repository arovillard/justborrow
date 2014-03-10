class ProductsController < ApplicationController
  before_filter :ensure_logged_in, :except => [:index,:show, :category_page]
  before_filter :find_product, :only => [:show, :edit, :update, :destroy]

  def index

    if params[:tag]
      @products = Product.all.tagged_with(params[:tag])
    elsif params[:search]
      @products = Product.search(params[:search])
    else
     @products = Product.all
    end
    @hash = Gmaps4rails.build_markers(@products) do |product, marker|
      marker.lat product.latitude
      marker.lng product.longitude
      marker.json({:id => product.id})
    end
    # remove empty lat/lng pairs
    @hash = @hash.reject do |marker|
      !marker[:lat] || !marker[:lng]
    end

    add_breadcrumb "Products", products_path
  end

  def show
    @rental = Rental.new
    @product = Product.find(params[:id])
    @product_images = @product.product_images.all
    add_breadcrumb 'products', product_path
  end

  def category_page
    @category = Category.find(params[:category_id])
    @category_products = @category.products
    @hash = Gmaps4rails.build_markers(@category_products) do |product, marker|
      marker.lat product.latitude
      marker.lng product.longitude
      marker.json({:id => product.id})
    end
    # remove empty lat/lng pairs
    @hash = @hash.reject do |marker|
      !marker[:lat] || !marker[:lng]
    end
  add_breadcrumb "Products", products_path
  end

  def new
    @product = Product.new
    @categories = Category.all
    @product_image = @product.product_images.build
    add_breadcrumb 'new product', new_product_path
  end

  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
         params[:product_images]['image'].each do |i|
            @product_image = @product.product_images.create!(:image => i, :product_id => @product.id)
         end
         format.html { redirect_to @product, notice: 'Product was successfully created.' }
       else
         format.html { render action: 'new' }
      end
    end

  end

  def edit
    add_breadcrumb 'edit product', edit_product_path
    @categories = Category.all
    session[:return_to] ||= request.referer
    # @product.product_images.each do |i|
    #   i.destroy
    # end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        if params[:product_images]
          params[:product_images]['image'].each do |i|
            @product_image = @product.product_images.create!(:image => i, :product_id => @product.id)
          end
        end
          format.html { redirect_to @product, notice: 'Product was successfully created.' }
       else
         format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_path }
      format.json { head :no_content }
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:lender_id, :title, :description, :price, :tag_list, :category_id, :product_id, :image, :address, :latitude, :longitude)
  end
end
