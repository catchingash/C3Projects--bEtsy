require 'httparty'

class OrdersController < ApplicationController
  SHIPPING_URI = "http://localhost:3333/quote&"
  ORIGIN = "Texarkana TX 75505 US"
  # Create an unless block to change this to rails.env during production

  before_action :set_order, only: [:cart, :checkout, :add_to_cart, :update, :receipt]
  before_action :set_seller_order, only: [:show]
  before_action :set_product, only: [:add_to_cart]
  before_action :set_seller, only: [:index, :show]
  before_action :require_seller_login, only: [:index, :show]
  before_action :active_shipping_call, only: [:shipping]

  def cart; end

  def active_shipping_call
    # hit the URI
    # @response = HTTParty.get(SHIPPING_URI + "#{ORIGIN}&#{@destination}&#{@packages}")
  end

  def shipping
    # @ups_option = grab stuff from the hashy mash
    # @fedex_option
  end

  def checkout
    @order.prepare_checkout!
    flash[:errors] = @order.errors unless @order.errors.empty?
  end

  def add_to_cart # OPTIMIZE: consider moving this elsewhere, i.e. ProductsController or OrderItemsController. !!!
    order_item = OrderItem.new(product_id: @product.id, order_id: @order.id, quantity_ordered: 1)
    if order_item.save
      flash[:messages] = MESSAGES[:successful_add_to_cart]
    else
      flash[:errors] = order_item.errors
    end

    redirect_to product_path(@product)
  end

  def update
    if @order.checkout!(checkout_params)
      redirect_to shipping_path
    else
      flash.now[:errors] = @order.errors
      @order.attributes = checkout_params
      render :checkout
    end
  end

  def receipt
    if @order.status == "paid"
      render :receipt
      session[:order_id] = nil
    else
      redirect_to root_path
    end
  end

  def index
    @orders = @seller.fetch_orders(params[:status])
    flash.now[:errors] = ERRORS[:no_orders] if @orders.length == 0
  end

  def show
    @order_items = @order.order_items.select { |item| item.seller.id == @seller.id }
  end

  private
    def checkout_params
      params.require(:order).permit(:buyer_name, :buyer_email, :buyer_street, :buyer_city, :buyer_state, :buyer_zip, :buyer_country, :buyer_card_short, :buyer_card_expiration)
    end

    def set_order
      if session[:order_id] && Order.find_by(id: session[:order_id])
        @order = Order.find(session[:order_id])
      else
        @order = Order.create
        session[:order_id] = @order.id
      end
    end

    def set_seller_order
      @order = Order.find(params[:order_id] ? params[:order_id] : params[:id])
    end

    def set_product
      @product = Product.find(params[:id])
    end
end
