require 'rails_helper'
require 'shipping_client'

RSpec.describe 'shipping_client' do
  let!(:user) { create :user}
  let!(:order) { create :order }
  let!(:buyer) { create :buyer }
  let(:package) { create :package }
  let(:response) { ShippingClient.log(package) }
  it "hits the api" do
    expect(response.response).to be_a Net::HTTPOK
  end

  it "returns the correct keys" do
    expect(response.keys).to eq ["id", "customer", "order_id",
                                 "service", "cost", "origin",
                                 "destination", "created_at", "updated_at"]
  end

end
