require 'httparty'

class ShippingClient
  TIMEOUT = 10 # TODO: decide if a 10-second timeout is appropriate
  RATE_COMPARE_URI = Rails.env.production? ? "https://adashipping.herokuapp.com/rates" : "http://localhost:3000/rates"
  SHIPPING_LOG_URI = Rails.env.production? ? "https://adashipping.herokuapp.com/logs/new" : "http://localhost:3000/logs/new"

  def self.handle_timeouts
    begin
      yield
    rescue Net::OpenTimeout, Net::ReadTimeout
      [] # FIXME: display an error message!!
    end
  end

  def self.rates(package)
    buyer = package.buyer
    seller = package.user

    handle_timeouts do
      HTTParty.post(RATE_COMPARE_URI,
        query: {
          origin: {
            city: buyer.city,
            state: buyer.state,
            zip: buyer.zip,
            country: buyer.country
          },
          destination: {
            city: seller.city,
            state: seller.state,
            zip: seller.zip,
            country: seller.country
          },
          package: {
            weight: package.weight,
            dimensions: [package.length, package.width, package.height],
            units: :imperial
          }
        },
        timeout: TIMEOUT
      )
    end
  end

  def self.log(package)
    order_id = package.buyer.order_id
    handle_timeouts do
      HTTParty.post(SHIPPING_LOG_URI,
        query: {
          log: {
            customer: "Bitsy",
            order_id: order_id,
            service: package.service,
            cost: package.cost * 100,
            origin: package.user.zip,
            destination: package.buyer.zip
          }
        },
        timeout: TIMEOUT
        )
    end
  end

end
