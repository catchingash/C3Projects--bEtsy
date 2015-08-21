require 'rails_helper'
require "vcr_setup"

RSpec.describe ShippingsController, type: :controller do

  describe "api_shipping_call receives a response" do
    #return to this later
  end

  describe "get_destination" do
    create :order
  end
end
