class Api::V1::OrdersController < ApplicationController
  attr_accessor :credit_card_number, :credit_card_exp_month, :credit_card_exp_year, :credit_card_cvv
    def create
      # @order = Order.new(order_params.merge(amount_cents: rand(1000..10000), payment_method: 'credit_card'))
      # if @order.save
        # render json: { order: @order, payment: @order.payment }, status: :created
      # else
        # render json: @response.errors, status: :unprocessable_entity
      # end
      credit_card_number = 4242424242424242
      credit_card_exp_month = 8
      credit_card_exp_year = 2024
      credit_card_cvv = 341
      token = Stripe::Token.create({
        card: {
          number: credit_card_number,
          exp_month: credit_card_exp_month,
          exp_year: credit_card_exp_year,
          cvc: credit_card_cvv,
        }
      })
      params = { amount: 500, currency: 'INR', payment_method: token}
      response = Stripe::PaymentIntent.create(params)
      self.stripe_id = response.id
      render json: self.stripe_id
    end

    
    private
    # def order_params
    #   params.require(:data).permit(:customer_id, :credit_card_number, :credit_card_exp_month, :credit_card_exp_year, :credit_card_cvv)
    # end
  end
