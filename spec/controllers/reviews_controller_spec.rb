require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:review_params) do { review: { rating: 4 } } end
  let(:invalid_params) do { review: { body: "text" } } end

  let(:product) { create(:product) }

  describe "POST #create" do

    context "valid params" do
      it "creates a Media record" do
        post :create, { product_id: product.id }.merge(review_params)
        expect(Review.count).to eq 1
      end

      it "redirects to the product show page" do
        post :create, { product_id: product.id }.merge(review_params)
        expect(subject).to redirect_to(product_path(product.id))
      end
    end

    context "invalid params" do
      it "does not persist invalid records" do
        post :create, { product_id: product.id }.merge(invalid_params)
        expect(Review.count).to eq 0
      end
    end
  end

end
