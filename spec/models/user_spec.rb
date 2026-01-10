require 'rails_helper'

describe User, type: :model do
    context 'validations' do
        it 'is valid with valid attributes' do
            user = User.new(email: 'test@example.com', name: 'Test User', password: 'password123')
            expect(user).to be_valid
        end
        it 'is not valid without an email' do
            user = User.new(name: 'Test User', password: 'password123')
            expect(user).not_to be_valid
        end
    
        it 'is not valid with a duplicate email' do
            User.create(email: 'test@example.com', name: 'Test User', password: 'password123')
            user = User.new(email: 'test@example.com', name: 'Test User', password: 'password123')
            expect(user).not_to be_valid
        end

        it 'is not valid without a password' do
            user = User.new(email: 'test@example.com', name: 'Test User')
            expect(user).not_to be_valid
        end
    end

    # 2. Test Associations
    describe 'associations' do
        it 'has many tasks' do
            association = described_class.reflect_on_association(:tasks)
            expect(association.macro).to eq(:has_many)
        end

        it 'destroys dependent tasks when user is deleted' do
            user = User.create!(email: 'boss@test.com', password: 'password')
            user.tasks.create!(title: 'Task 1', status: 'pending', priority: 1)
            
            expect { user.destroy }.to change(Task, :count).by(-1)
        end
    end

    # 3. Test Security (Password Encryption)
    describe 'password encryption' do
        it 'encrypts the password using BCrypt' do
        user = User.create!(email: 'secure@test.com', password: 'secret_password')
        expect(user.password_digest).to_not be_nil
        expect(user.password_digest).to_not eq('secret_password')
        end
    end

end