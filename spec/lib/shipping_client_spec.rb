require 'rails_helper'
require 'shipping_client'

RSpec.describe 'shipping_client' do
  let!(:user) { create :user}
  let!(:order) { create :order }
  let!(:buyer) { create :buyer }
  let(:package) { create :package }
  it "hits the api" do
    response = ShippingClient.log(package)
    expect(response.response).to be_a Net::HTTPOK
  end

end
