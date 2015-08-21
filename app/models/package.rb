require 'shipping_client'

class Package < ActiveRecord::Base
  belongs_to :user
  belongs_to :buyer
  has_many :order_items

  validates :weight, :length, :width, :height, :user_id, :buyer_id, presence: true

  def self.update_ship_info(info)
    info.each do |pack_id, service|
      package = Package.find(pack_id.to_i)
      matching_rate = nil

      rates = ShippingClient.rates(package)
      rates.each do |rate|
        matching_rate = rate if rate["service"] == service
      end

      if package.update(service: matching_rate["service"], cost: matching_rate["price"]/100)
        ShippingClient.log(package)
      else
        # FIXME: implement
      end
    end
  end
end
