class TasksController < ApplicationController
  
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
