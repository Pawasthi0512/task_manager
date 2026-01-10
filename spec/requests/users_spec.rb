require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }

  # Test for POST /users (Sign up)
  describe "POST /users" do
    let(:valid_attributes) do
      { name: 'New User', email: 'new@example.com', password: 'password123' }
    end

    context "when the request is valid" do
      before { post "/users", params: valid_attributes }

      it "creates a user" do
        expect(json['name']).to eq('New User')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end

      it "does not return the password_digest" do
        expect(json).not_to have_key('password_digest')
      end
    end

    context "when the request is invalid" do
      before { post "/users", params: { name: 'No Email' } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test for GET /users
  describe "GET /users" do
    before { get "/users" }

    it "returns users" do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test for GET /users/:id
  describe "GET /users/:id" do
    before { get "/users/#{user_id}" }

    context "when the record exists" do
      it "returns the user" do
        expect(json['id']).to eq(user_id)
        expect(json['email']).to eq(user.email)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end
end