class MessagesController < ApplicationController

  def index
    @product = Product.find(params[:product_id])
    @rental = Rental.find(params[:rental_id])
    @messages = @rental.messages

  end

  def new
    @product = Product.find(params[:product_id])
    @rental = Rental.find(params[:rental_id])
    @message = Message.new
  end

  def create
    @product = Product.find(params[:product_id])
    @rental = Rental.find(params[:rental_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.rental = @rental
    if @message.save
      redirect_to product_rental_messages_path(@product, @rental), :notice => "Message Posted!"
    else
      render :new
    end
  end

private
  def message_params
    params[:message].permit(:content, :user_id, :rental_id)
  end
end
