class TasksController < ApplicationController
  
  def index
    @user = User.find(session[:user_id])
    @user_tasks = Task.where(user_id: @user.id)
    if @user.id == session[:user_id]
      @current_user = true
    else
      @current_user = false
    end
    render "tasks/index"
  end
  
  def show
    @task = Task.find(params(:id))
    render "users/show"
  end
  
  def new
    @user = User.find(session[:user_id])
    @new_task = Task.new
  end
  
  def create
    name = params["tasks"]["name"]
    user_id = params["tasks"]["user_id"]
    @new_task = Task.create({"name" => name, "user_id" => user_id})
    redirect_to "/users/show"
  end
  
  def destroy
    task_id = Task.find(params[:id])
    task_id.destroy
    redirect_to "/users/show"
  end
  
  private
  
end
