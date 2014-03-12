class CategoriesController < ApplicationController
  before_filter :location,  :only => [:show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_url, :notice => "Category #{@category.category_name} has been created!"
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.near([@location.latitude, @location.longitude], 25)
    @hash = Gmaps4rails.build_markers(@products) do |product, marker|
      marker.lat product.latitude
      marker.lng product.longitude
      marker.json({:id => product.id})
    end
    # remove empty lat/lng pairs
    @hash = @hash.reject do |marker|
      !marker[:lat] || !marker[:lng]
    end
  end

  def destroy
  end

  private
  def category_params
    params.require(:category).permit(:category_name)
  end

end
