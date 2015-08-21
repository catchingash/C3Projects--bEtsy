require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  # INDEX ACTION__________________________________________________________________

  describe "GET #index" do

    it "renders the index template" do
      get :index

      expect(response).to render_template("index")
    end
  end

  # SHOW ACTION__________________________________________________________________

  describe "GET #show" do
    before :each do
      @product = create(:product)
    end

    it "returns successfully with an HTTP 200 status code" do
      get :show, id: @product

      expect(response).to be_success
    end

    it "renders the show view" do
      get :show, id: @product

      expect(response).to render_template("show")
    end
  end

  # NEW ACTION__________________________________________________________________

  describe "GET #new" do
    before :each do
      user = create(:user)
      session[:user_id] = user.id

      get :new, user_id: user
    end

    it "renders the new view" do
      expect(response).to render_template("new")
    end
  end

  # CREATE ACTION__________________________________________________________________

  describe "POST #create" do
    context "valid params" do
      before :each do
        user = create(:user)
        session[:user_id] = user.id

        post :create, product: attributes_for(:product, user_id: user)
      end

      it "creates a product" do
        expect(Product.count).to eq 1
      end

      it "redirects to the product show page" do
        expect(subject).to redirect_to(product_path(assigns(:product)))
      end
    end

    context "invalid params (stock < 0)" do
      before :each do
        user = create(:user)
        session[:user_id] = user.id

        post :create, product: attributes_for(:product, user_id: user.id, stock: -1)
      end

      it "doesn't save a product" do
        expect(Product.count).to eq 0
      end

      it "redirects to a new product page" do
        expect(response).to render_template("new")
      end
    end
  end

  # EDIT ACTION__________________________________________________________________

  describe "GET #edit" do
    before :each do
      user = create(:user)
      product = create(:product, user: user)
      session[:user_id] = user.id

      get :edit, id: product.id
    end

    it "renders the edit view" do
      expect(response).to render_template("edit")
    end
  end

  # UPDATE ACTION__________________________________________________________________

  describe "PUT #update" do
    context "valid params" do
      before :each do
        user = create(:user)
        session[:user_id] = user.id
        @product = create(:product, user: user)
      end

      let(:update_params) { { product: { name: 'product_changed_name', price: 10.99, stock: 10 } } }

      it "updates a product" do
        put :update, { id: @product.id }.merge(update_params)
        @product.reload

        expect(Product.find(1).name).to eq 'product_changed_name'
      end

      it "redirects to merchant product show page" do
        put :update, { id: @product.id }.merge(update_params)
        @product.reload

        expect(response).to redirect_to(user_path(@product.user_id))
      end
    end

    context "invalid product params" do
      before :each do
        user = create(:user)
        session[:user_id] = user.id

        @product_params = attributes_for(:product, user_id: user.id, name: 'fishies')
        @product = Product.create(@product_params)

        @product_params[:name] = nil
        put :update, { id: @product.id }.merge({ product: @product_params })
        @product.reload
      end

      it "doesn't update the product" do
        expect(@product.name).to eq 'fishies'
      end

      it "redirects to the edit page" do
        expect(response).to render_template('edit', session[:user_id])
      end
    end
  end

  # RETIRE ACTION__________________________________________________________________

  describe "PATCH#retire" do
    before :each do
      user = create(:user)
      session[:user_id] = user.id

      @product = create(:product, user: user)
    end

    it "retires product and redirects to the merchant product page " do
      patch :retire, { id: @product.id }
      @product.reload

      expect(response).to redirect_to(user_path(@product.user_id))
      expect(@product.retired).to eq(true)
    end
  end

  # MERCHANT_PRODUCTS ACTION__________________________________________________________________

  describe "GET#merchant_products" do
    before :each do
      user = create(:user)
      session[:user_id] = user.id

      get :merchant_products, { id: user.id }
    end

    it "renders merchant products page " do
      expect(response).to render_template("merchant_products", session[:user_id])
    end
  end

end
