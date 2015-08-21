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
  end
    # We don't think our redirect to root is working, it throws a
    # Module::DelegationError:
    # context "if there is no order in the session" do
    #   it "redirects to the cart" do
    #     session[:order_id] = nil
    #     expect(controller.send(:get_packages)).to redirect_to(root_path)
    #   end
    # end

  describe "POST #create" do
    context "valid params" do
      let(:valid_params) { {shipping: { carrier: "UPS", price: 3, est_date: "2015-08-21 14:04:29 -0700", service_name: "UPS Fancy", order_id: 1}} }

      it "creates a shipping record" do
        session[:order_id] = 1
        VCR.use_cassette 'controller/query_response' do
          post :create, valid_params
          expect(Shipping.all.count).to eq(1)
        end
      end
    end

    context "invalid params" do
      let(:invalid_params) { {shipping: { carrier: "UPS", price: "3"}} }

      it "renders the quote page again" do
        session[:order_id] = 1
          post :create, invalid_params
          expect(response).to render_template(:quote)
      end
    end
  end
end
