require 'httparty'
require 'timeout'

class ShippingsController < ApplicationController

  if Rails.env.production?
    SHIPPING_URI = "https://shrouded-inlet-4900.herokuapp.com/"
  else
    SHIPPING_URI = "http://localhost:3333/"
  end

  ORIGIN_HASH = {origin_city: "Texarkana",
                 origin_state: "TX",
                 origin_zip: "75505",
                 origin_country: "US"}

  before_action :active_shipping_call, only: [:quote]

  def active_shipping_call
    get_destination
    get_packages
    query = { origin: ORIGIN_HASH, destination: @destination_hash, packages: @packages }
    # hit the URI, displays error if request takes too long
    begin
      status = Timeout::timeout(6) {
        @response = HTTParty.get(SHIPPING_URI + "quotes", query: query)
      }
    rescue Timeout::Error
      redirect_to :back, flash: { errors: ERRORS[:timeout] }
    end
  end

  # renders the shipping options for the customer
  def quote
    @ups = @response["ups"]
    @fedex = @response["fedex"]

    @shipping = Shipping.new
  end

  def create
    @shipping = Shipping.new(create_params)
    @shipping.order_id = session[:order_id]
    if @shipping.save
      query = { carrier: @shipping.carrier, service_name: @shipping.service_name,
                price: @shipping.price, est_date: @shipping.est_date,
                order_id: @shipping.order_id, store: "TuxBetsy" }
      HTTParty.post(SHIPPING_URI + "audit", query: query)
      redirect_to receipt_path
    else
      flash.now[:errors] = @shipping.errors
      render :quote
    end
  end

  private

    # munge the address to prepare to pass to the api
    def get_destination
      if session[:order_id].nil?
        redirect_to cart_path
      else
        order = Order.find(session[:order_id])
        @destination_hash = {
          destination_city: order.buyer_city,
          destination_state: order.buyer_state,
          destination_zip: order.buyer_zip,
          destination_country: order.buyer_country
        }
      end
    end

    # munge the packages to prepare to pass to the api
    def get_packages
      if session[:order_id].nil?
        redirect_to cart_path
      else
        order_items = OrderItem.where(order_id: session[:order_id])
        items_hash = {}
        counter = 1
        order_items.each do |item|
          product = Product.find(item.product_id)
          each_item_hash= {
            quantity: item.quantity_ordered,
            weight: product.weight,
            length: product.length,
            width: product.width,
            height: product.height
          }
          items_hash[counter] = each_item_hash
          counter += 1
        end

        @packages = items_hash
      end
    end

    def create_params
      params.require(:shipping).permit(:carrier, :price, :est_date, :service_name, :order_id)
    end

end
