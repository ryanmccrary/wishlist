class StripeChargesService
  DEFAULT_CURRENCY = 'usd'.freeze

  def initialize(params)
    @stripe_email = params[:stripeEmail]
    @stripe_token = params[:stripeToken]
    @order = params[:order_id]
  end

  def call
    create_charge(create_customer)
  end

  private

  attr_accessor :user, :stripe_email, :stripe_token, :order

  def retrieve_customer(stripe_token)
    Stripe::Customer.retrieve(stripe_token)
  end

  def create_customer
    customer = Stripe::Customer.create(
      email: stripe_email,
      source: stripe_token
    )
    # user.update(stripe_token: customer.id)
    customer
  end

  def create_charge(customer)
    Stripe::Charge.create(
      customer: customer.id,
      amount: 100,
      description: customer.email,
      currency: DEFAULT_CURRENCY
    )
  end

  # def order_amount
  #   Order.find_by(id: order).amount
  # end
end
