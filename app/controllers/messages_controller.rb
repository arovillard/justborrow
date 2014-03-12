class MessagesController < ApplicationController
  before_filter :ensure_logged_in

  def index
    @rental = Rental.find(params[:rental_id])
    @product = @rental.product
    @messages = @rental.messages.all.reverse &:created_at

  end

  def new
    @rental = Rental.find(params[:rental_id])
    @product = @rental.product
    @message = Message.new
  end

  def create
    @rental = Rental.find(params[:rental_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.rental = @rental
    if @message.save
      redirect_to rental_messages_path(@rental), :notice => "Message Posted!"
    else
      render :new
    end
  end

private
  def message_params
    params[:message].permit(:content, :user_id, :rental_id)
  end
end
