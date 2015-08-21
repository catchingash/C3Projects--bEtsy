require 'rails_helper'
require "vcr_setup"

RSpec.describe ShippingsController, type: :controller do

  describe "api_shipping_call receives a response" do
    #return to this later
  end

  describe "get_destination" do
    it "creates a hash containing destination info" do
      create :order
      session[:order_id] = 1
      expect(controller.send(:get_destination)).to be_an_instance_of Hash
    end
  end

  describe "get_packages" do
    it "creates a hash containing packages for each order item" do
      create :order
      create :product
      create :order_item
      session[:order_id] = 1
      expect(controller.send(:get_packages)).to be_an_instance_of Hash
    end
  end
end
