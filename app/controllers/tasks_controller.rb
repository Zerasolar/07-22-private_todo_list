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
  end
  
  def new
    @new_task = Task.new
  end
  
  def create
    name = params["tasks"]["name"]
    @new_task = Task.create({"name" => name})
    redirect_to "user_path(session[:user_id])"
  end
  
  def destroy
    task = Task.find(session[:user_id])
    task.delete
    session[:user_id] = nil
    redirect_to "/users"
  end
  
  def edit
  end
  
  def update
  end
  
  private
  
  def task_params
    params["tasks"].permit(:name)
  end
  
  def get_user
    @user = User.find(session[:user_id])
  end
  
  def get_task
    @task = Task.find(params[:id])
  end
end
