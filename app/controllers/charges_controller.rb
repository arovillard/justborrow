class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @amount = (params[:amount].to_f * 100.0).to_i

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => params[:description],
      :currency    => 'cad'
    )

    rental = Rental.find(params[:rental_id])
    rental.update( :borrower_acceptance => true )

    redirect_to user_path(current_user)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to user_path(current_user)
  end

end
