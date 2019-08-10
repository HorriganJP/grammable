require 'rails_helper'

RSpec.describe GramsController, type: :controller do

  describe "grams#index" do
    context "as an authenticiated user" do
      it "should require users to be logged in" do 
        get :new
        expect(response).to redirect_to new_user_session_path
      end

      it "should successfully show the page" do
        @user = User.create(email: "test@email.com", password: "password")
        sign_in @user
        get :new
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
    context "as an authenticiated user" do
      before do
        sign_in @user do
          it "should properly deal with validation errors" do
            post :create,  params: { gram: { message: '' } }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(gram_count).to eq Gram.count
          end
        end
      end
    end
  end

  describe "grams#create action" do
    it "should require users to be logged in" do
      post :create, params: { gram: { message: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end
    
    context "as an authenticiated user" do
      before do
        sign_in @user do
          it "should successfully post gram entry to database" do
            post :create, params: { gram: { message: 'Hello!'} }
            expect(response).to redirect_to root_path

            gram = Gram.last
            expect(gram.message).to eq("Hello!")
            expect(gram.user).to eq(user)
          end
        end
      end
    end
    context "as an un-authenticated user" do
      before do
        sign_out @user do
          it "should not post a gram and redirect user to root_path" do
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response).to redirect_to new_user_session_path
          end
        end
      end
    end
  end
end

