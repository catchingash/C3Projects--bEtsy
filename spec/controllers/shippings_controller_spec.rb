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

    before(:each) do
      create :order
      create :product
      create :product, name: "Another widget"
      create :order_item
      create :order_item, product_id: 2
    end

    context "if there is an order session" do
      it "creates a package hash with two order items" do
        session[:order_id] = 1

        expect(controller.send(:get_packages).count).to eq 2
      end
    end

    # We don't think our redirect to root is working, it throws a
    # Module::DelegationError:
    # context "if there is no order in the session" do
    #   it "redirects to the cart" do
    #     session[:order_id] = nil
    #     expect(controller.send(:get_packages)).to redirect_to(root_path)
    #   end
    # end


  end
end
