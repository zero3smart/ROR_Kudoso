require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ContentRatingsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # ContentRating. As you add validations to ContentRating, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContentRatingsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all content_ratings as @content_ratings" do
      content_rating = ContentRating.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:content_ratings)).to eq([content_rating])
    end
  end

  describe "GET show" do
    it "assigns the requested content_rating as @content_rating" do
      content_rating = ContentRating.create! valid_attributes
      get :show, {:id => content_rating.to_param}, valid_session
      expect(assigns(:content_rating)).to eq(content_rating)
    end
  end

  describe "GET new" do
    it "assigns a new content_rating as @content_rating" do
      get :new, {}, valid_session
      expect(assigns(:content_rating)).to be_a_new(ContentRating)
    end
  end

  describe "GET edit" do
    it "assigns the requested content_rating as @content_rating" do
      content_rating = ContentRating.create! valid_attributes
      get :edit, {:id => content_rating.to_param}, valid_session
      expect(assigns(:content_rating)).to eq(content_rating)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ContentRating" do
        expect {
          post :create, {:content_rating => valid_attributes}, valid_session
        }.to change(ContentRating, :count).by(1)
      end

      it "assigns a newly created content_rating as @content_rating" do
        post :create, {:content_rating => valid_attributes}, valid_session
        expect(assigns(:content_rating)).to be_a(ContentRating)
        expect(assigns(:content_rating)).to be_persisted
      end

      it "redirects to the created content_rating" do
        post :create, {:content_rating => valid_attributes}, valid_session
        expect(response).to redirect_to(ContentRating.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved content_rating as @content_rating" do
        post :create, {:content_rating => invalid_attributes}, valid_session
        expect(assigns(:content_rating)).to be_a_new(ContentRating)
      end

      it "re-renders the 'new' template" do
        post :create, {:content_rating => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested content_rating" do
        content_rating = ContentRating.create! valid_attributes
        put :update, {:id => content_rating.to_param, :content_rating => new_attributes}, valid_session
        content_rating.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested content_rating as @content_rating" do
        content_rating = ContentRating.create! valid_attributes
        put :update, {:id => content_rating.to_param, :content_rating => valid_attributes}, valid_session
        expect(assigns(:content_rating)).to eq(content_rating)
      end

      it "redirects to the content_rating" do
        content_rating = ContentRating.create! valid_attributes
        put :update, {:id => content_rating.to_param, :content_rating => valid_attributes}, valid_session
        expect(response).to redirect_to(content_rating)
      end
    end

    describe "with invalid params" do
      it "assigns the content_rating as @content_rating" do
        content_rating = ContentRating.create! valid_attributes
        put :update, {:id => content_rating.to_param, :content_rating => invalid_attributes}, valid_session
        expect(assigns(:content_rating)).to eq(content_rating)
      end

      it "re-renders the 'edit' template" do
        content_rating = ContentRating.create! valid_attributes
        put :update, {:id => content_rating.to_param, :content_rating => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested content_rating" do
      content_rating = ContentRating.create! valid_attributes
      expect {
        delete :destroy, {:id => content_rating.to_param}, valid_session
      }.to change(ContentRating, :count).by(-1)
    end

    it "redirects to the content_ratings list" do
      content_rating = ContentRating.create! valid_attributes
      delete :destroy, {:id => content_rating.to_param}, valid_session
      expect(response).to redirect_to(content_ratings_url)
    end
  end

end