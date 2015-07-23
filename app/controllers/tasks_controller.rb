class TasksController < ApplicationController
  
  def index
    @user = User.find(session[:user_id])
    @user_tasks = Task.where(user_id: @user.id)
    if @user.id == session[:user_id]
      @current_user = true
    else
      @current_user = false
    end
    render :show
  end
  
  def show
    @task = Task.find(params(:id))
    render :show
  end
  
  def new
    @user = User.find(session[:user_id])
    @new_task = Task.new
  end
  
  def create
    @new_task = Task.create(task_params)
    redirect_to to_do_path
  end
  
  def destroy
    task_id = Task.find(params[:id])
    task_id.destroy
    redirect_to to_do_path
  end
  
  private
  
  def task_params
    params[:tasks].permit(:name, :user_id)
  end
  
end
