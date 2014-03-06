class CategoriesController < ApplicationController
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

  def destroy
  end

  def category_params
    params.require(:category).permit(:category_name)
  end

end
