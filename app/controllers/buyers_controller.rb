class BuyersController < ApplicationController
  include ApplicationHelper

  def new
    order = Order.find(session[:order_id])
    @buyer = order.buyer ? order.buyer : Buyer.new
    @buyer.order_id = session[:order_id]

    if logged_in?
      @user = User.find(session[:user_id])
    end
  end

  def create
    order = Order.find(session[:order_id])
    @buyer = order.buyer ? order.buyer : Buyer.new

    if @buyer.update(buyer_params)
      redirect_to shipping_options_path
    else
      render :new
    end
  end

  def shipping_options
    order = Order.find(session[:order_id])
    @estimates = order.fetch_shipping_rates
  end

  def order_complete
    Package.update_ship_info(params[:packages])
    transaction

    redirect_to buyer_confirmation_path(session[:order_id])
  end

  def confirmation
    @order = Order.find(session[:order_id])
    session[:order_id] = nil
  end

  private

  def buyer_params
    params.require(:buyer).permit(:name, :email,
      :address, :city, :state, :zip,
      :credit_card, :cvv, :exp, :order_id)
  end
end
