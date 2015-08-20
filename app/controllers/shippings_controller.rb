require 'httparty'
class ShippingsController < ApplicationController
  SHIPPING_URI = "http://localhost:3333/quotes"
  ORIGIN_HASH = {origin_city: "Texarkana",
                 origin_state: "TX",
                 origin_zip: "75505",
                 origin_country: "US"}
  # Create an unless block to change this to rails.env during production

  before_action :active_shipping_call, only: [:quote]

  def active_shipping_call
    get_destination
    get_packages
    query = { origin: ORIGIN_HASH, destination: @destination_hash, packages: @packages }
    # hit the URI
    # @response = HTTParty.get(SHIPPING_URI)
    @response = HTTParty.get(SHIPPING_URI, query: query)
  end

  def quote
    @ups = @response["ups"]
    @fedex = @response["fedex"]
    # @ups = @response["ups"].rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
    # @fedex = @response["fedex"].rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
    # @ups_option = grab stuff from the hashy mash
    # @fedex_option
  end

  private

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
      # items_string = items_hash.to_s.gsub(":", "").gsub("=>", ": ")
      @packages = items_hash
    end
  end
end
