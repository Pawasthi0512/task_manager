class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = current_user.tasks

    respond_to do |format|
      format.html
      format.json { render json: @tasks }
  end

  def show
    @task = Task.find(params[:id])
    render json: @task
    rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :not_found
  end
end
