require 'rails_helper'

RSpec.describe GramsController, type: :controller do

  #TEST SHOW
  describe "grams#show action" do
    it "should successfully show the page if the gram is found" do
      gram = FactoryBot.create(:gram)
      get :show, params: {id: gram.id }
      expect(response).to have_http_status(:success)
    end

    it "should return 404 error if gram not found" do
      get :show, params: { id: 'TACOCAT' }
      expect(response).to have_http_status(:not_found)
    end
  end

  #TEST EDIT
  describe "grams#edit action" do
    it "should successfully show the edit form if the gram is found" do
      gram = FactoryBot.create(:gram)
      get :edit, params: { id: gram.id }
      expect(response).to have_http_status(:success)
    end

    #TEST
    it "should return a 404 error message if the gram is not found" do
      get :edit, params: { id: 'nil' }
      expect(response).to have_http_status(:not_found)
    end
  end

  #TEST SHOW INDEX
  describe "grams#index" do
    context "as an authenticiated user" do
      it "should require users to be logged in" do 
        get :new
        expect(response).to redirect_to new_user_session_path
      end

      #TEST 
      it "should successfully show the page" do
        user = FactoryBot.create(:user)
        sign_in user

        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

  #TEST CREATE
  describe "grams#create action" do
    context "as an authenticiated user" do
      before do
        sign_in user do
          it "should properly deal with validation errors" do
            post :create,  params: { gram: { message: '' } }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(gram_count).to eq Gram.count
          end
        end
      end
    end
  end

  #TEST CREATE
  describe "grams#create action" do
    it "should require users to be logged in" do
      post :create, params: { gram: { message: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end

    context "as an authenticiated user" do
      before do
        sign_in user do
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
        sign_out user do
          it "should not post a gram and redirect user to root_path" do
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response).to redirect_to new_user_session_path
          end
        end
      end
    end
  end

  #TEST UPDATE
  describe "grams#update action" do
    it "should successfully update gram" do
      gram = FactoryBot.create( :gram, message: "Initial Value" )
      patch :update, params: { id: gram.id, gram: { message: 'Changed' } }
      expect(response).to redirect_to root_path
      gram.reload
      expect(gram.message).to eq "Changed"
    end

    it "should return 404 if gram not found" do
      patch :update, params: { id: 'YOLOSWAG', gram: { message: 'Changed' } }
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with unprocessable_entity if gram not valid" do
      gram = FactoryBot.create( :gram, message: "Initial Value" )
      patch :update, params: { id: gram.id, gram: { message: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      gram.reload
      expect(gram.message).to eq "Initial Value"
    end
  end

  describe "gram#destroy action" do
    it "should successfully destory gram" do
      gram = FactoryBot.create(:gram)
      delete :destroy, params: { id: gram.id }
      expect(response).to redirect_to root_path
      gram = Gram.find_by_id(gram.id)
      expect(gram).to eq nil
    end
    it "should return a 404 message if we cannot find gram" do
      delete :destroy, params: { id: 'TACOCAT' }
      expect(response).to have_http_status(:not_found)
    end
  end
end

