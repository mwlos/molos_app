class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,    only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @title= " Sign up "
    
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
   
  def edit
  end
  

  def create 
    @user = User.new(params[:user]) #this creates a new user object with the data you entered before.
    if @user.save #if the data is valid, save it
      sign_in @user
      flash[:success]="Welcome to the Molos App!"
      redirect_to @user #and go to the @user show action
    else
      @title=" Sign up "
      render 'new' #edit the invalid user data
    end
  end
  
  
  def destroy
    User.finf(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def signed_in_user
      redirect_to signin_url, notice: "Pleaseeeee appear." unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  def admin_user
   redirect_to(root_url) unless current_user.admin?
  end               
end
