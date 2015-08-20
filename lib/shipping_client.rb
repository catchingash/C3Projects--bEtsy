require 'httparty'

class ShippingClient
  RATE_COMPARE_URI = Rails.env.production? ? "IMPLEMENT ME" : "http://localhost:3000/rates"
  # FIXME: production URI not implemented

  def self.handle_timeouts
    begin
      yield
    rescue Net::OpenTimeout, Net::ReadTimeout
      [] # FIXME: display an error message!!
    end
  end

  # # FIXME: WIP!
  def self.rates(buyer, seller, package) # OPTIMIZE: it would be nice to not pass in the objects.
    # handle_timeouts do
    #   HTTParty.post(RATE_COMPARE_URI,
    #     query: {
    #       origin: {
    #         city: buyer.city,
    #         state: buyer.state,
    #         zip: buyer.zip,
    #         country: buyer.country
    #       },
    #       destination: {
    #         city: seller.city,
    #         state: seller.state,
    #         zip: seller.zip,
    #         country: seller.country
    #       },
    #       package: {
    #         weight: 12,
    #         dimensions: [15, 10, 4.5],
    #         units: :imperial
    #       }
    #     },
    #     timeout: 10 # TODO: decide if a 10-second timeout is appropriate
    #   )
    end

    def self.log
      handle_timeouts do
        # FIXME: Katie is going to fill this in :)
      end
    end
  end
end
