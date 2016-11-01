class ChargesController < ApplicationController
  def create
    @amount = params[:amount]

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    begin
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )
      flash[:success] = "Your purchase is complete!"
      redirect_to :back
    rescue Stripe::CardError => e 
      flash[:danger] = e.message
      render 'businesses/#{params[:id]}'
    end
  end
end
