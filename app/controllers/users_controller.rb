class UsersController < ApplicationController
  
  def index
    if !params["log_out"].nil?
      session[:user_id] = nil
    end
  end
  
  def login
  end
  
  def authenticate_login
    entered_email = params["users"]["email"]
    @user_email = User.find_by(email: entered_email)

    if !@user_email.nil?
      @valid = true
      given_pw = params["users"]["password"]
      actual_pw = BCrypt::Password.new(@user_email.password)
      if actual_pw == given_pw
        session[:user_id] = @user_email.id
        redirect_to dashboard_path
      else
        @valid = false
        render "login"
      end
    else
      @valid = false
      render "login"
    end
  end
  
  def show
    @user = User.find(session[:user_id])
    @tasks = Task.where(user_id: @user.id)
    render :show
  end
  
  def new
    @new_user = User.new
  end
  
  def create
    email = params["users"]["email"]
    password = BCrypt::Password.create(params["users"]["password"])
    @new_user = User.create({"email" => email, "password" => password})
    redirect_to dashboard_path
  end
  
  def destroy
    user = User.find(session[:user_id])
    user.delete
    session[:user_id] = nil
    redirect_to users_path
  end
  
  def edit
    @user = User.find(session[:user_id])
    render :edit
  end
  
  def update
    @user = User.find(session[:user_id])
    @user.email = params["users"]["email"]
    encrypted_password = BCrypt::Password.create(params["users"]["password"])
    @user.password = encrypted_password
    @user.save
    redirect_to dashboard_path
  end
  
end
