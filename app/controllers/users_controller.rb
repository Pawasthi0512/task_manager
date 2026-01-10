class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users.as_json(except: :password_digest)
  end

  def show
    @user = User.find(params[:id])
    render json: @user.as_json(except: :password_digest)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user.as_json(except: :password_digest), status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Strong Parameters: only allow name, email, and password through
  def user_params
    if params[:user].present?
      params.require(:user).permit(:name, :email, :password)
    else
      params.permit(:name, :email, :password)
    end
  end
end
