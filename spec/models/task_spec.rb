require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'strict schema' do
    it 'has only the expected database columns' do
      expected_columns = [
        "id", 
        "title", 
        "description", 
        "status", 
        "priority", 
        "due_date", 
        "user_id", 
        "created_at", 
        "updated_at"
      ]
      
      # .column_names returns an array of strings representing the DB columns
      actual_columns = Task.column_names
      expect(actual_columns).to match_array(expected_columns)
    end
  end

  describe 'associations' do
    it 'has many tasks' do
      association = described_class.reflect_on_association(:tasks)
      expect(association.macro).to eq(:has_many)
    end

    it 'destroys dependent tasks' do
      association = described_class.reflect_on_association(:tasks)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  describe 'auth' do
    it 'has a password digest field' do
      expect(User.new).to respond_to(:password_digest)
    end
  end
end