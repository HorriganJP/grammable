require 'rails_helper'

RSpec.describe GramsController, type: :controller do

  describe "grams#index" do
    context "as an authenticiated user" do
      before do
      end

      it "should successfully show the page" do
        @user = User.create(email: "test@email.com", password: "password")
        sign_in @user
        get :index
        expect(response).to have_http_status(:success)
      end

      # it "should redirect if user is not logged in" do
      #   @user != @current_user do
      #     expect(response).to redirect_to root_path
      #   end
      # end
    end
  end

  describe "grams#create action" do
    before do
      sign_in @user do
        it "should properly deal with validation errors" do
          post :create,  params: { gram: { message: '' } }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(Gram.count).to eq 0
        end
      end
    end
  end
  #describe "grams#new" do
  #  context "as an authenticiated user" do
  #    it "should successfuly show new form page" do
  #      sign_in @user
  #      get :new
  #      expect(response).to have_http_status(:success)
  #    end
  #  end
  #end

  describe "grams#create action" do
    before do
      sign_in @user do
        it "should successfully post gram entry to database" do
          post :create, params: { gram: { message: 'Hello!'} }
          expect(response).to redirect_to root_path

          gram = Gram.last
          expect(gram.message).to eq("Hello!")
        end

        # it "should properly deal with validation errors" do
        #   post :create,  params: { gram: { message: '' } }
        #   expect(response).to have_http_status(:unprocessable_entity)
        #   expect(Gram.count).to eq 0
        # end
      end
    end
  end
end

