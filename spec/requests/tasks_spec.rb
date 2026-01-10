require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  # Setup: Create a user and some tasks
  let!(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 3, user: user) }
  let(:task_id) { tasks.first.id }

  # Test for GET /tasks
  describe "GET /tasks" do
    before { get "/tasks" }

    it "returns tasks" do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test for GET /tasks/:id
  describe "GET /tasks/:id" do
    before { get "/tasks/#{task_id}" }

    context "when the record exists" do
      it "returns the task" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(task_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:task_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

end
