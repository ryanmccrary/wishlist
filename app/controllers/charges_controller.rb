class ChargesController < ApplicationController

  rescue_from Stripe::CardError, with: :catch_exception
  def new
  end

  def create
    StripeChargesService.new(charges_params).call
    redirect_to new_charge_path
  end

  private

  def charges_params
    params.permit(:stripeEmail, :stripeToken, :order_id)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end
end
