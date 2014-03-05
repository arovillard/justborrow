class UsersController < ApplicationController

  add_breadcrumb "home", :root_path
  add_breadcrumb "my", :my_path

  def new
    @user = User.new
    add_breadcrumb 'new user', new_user_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @products = @user.products

    # add_breadcrumb 'your products', user_products_path
  end

  def edit
    @user = User.find(params[:id])

    add_breadcrumb 'edit profile', edit_user_path

  end

  def update
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
