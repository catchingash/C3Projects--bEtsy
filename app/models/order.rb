require 'shipping_client'

class Order < ActiveRecord::Base
  # ASSOCIATIONS --------------------------------------------------------
  has_many :order_items
  has_one :buyer
  before_create :set_order_status

  def subtotal
    order_items.reduce(0) { |sum, order_item| sum + order_item.total_price }
  end

  def shipping_total
    packages.sum(:cost)
  end

  def total
    subtotal + shipping_total
  end

  def fetch_shipping_rates
    create_packages

    estimates = []
    packages.each do |package|
      rates = ShippingClient.rates(package)
      estimates << { package => rates }
    end

    return estimates
  end

  def create_packages # FIXME: there is zero error handling in this method.
    delete_existing_packages

    cart = order_items.group_by{ |order_item| order_item.product.user }
    cart.each do |seller, order_items|
      weights = []
      lengths = []
      widths = []
      heights = []

      order_items.each do |order_item|
        product = order_item.product
        quantity = order_item.quantity

        weights << product.weight * quantity
        lengths << product.length
        widths << product.width * quantity
        heights << product.height
      end

      package = Package.new

      package.weight = weights.reduce(:+)
      package.height = heights.max
      package.length = lengths.max
      package.width = widths.reduce(:+)

      package.user_id = seller.id
      package.buyer_id = buyer.id # buyer == self.buyer. We're working with an instance of an order.

      package.save

      order_items.each do |order_item|
        order_item.update(package_id: package.id)
      end
    end
  end

  def packages
    Package.where("buyer_id = ?", buyer.id)
  end

  private

  def delete_existing_packages
    packages.destroy_all
  end

  def set_order_status
    self.status = "pending"
  end

end
