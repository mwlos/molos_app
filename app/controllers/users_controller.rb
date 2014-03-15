class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new 
    @user = User.new #this creates a empty user object to be filled with signup data
    @title = "Sign up"
  end

  def create 
    @user = User.new(user_params) #this creates a new user object with the data you entered before.
    if @user.save #if the data is valid, save it
      sign_in @user
      flash[:success]="Welcome to the Molos App!"
      redirect_to @user #and go to the @user show action
    else
      render 'new' #edit the invalid user data
    end
  end
  
  private
  
   def user_params
     params.require(:user).permit(:name,:email,:password,:password_confirmation)
   end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to user_url(@user)
    else
      render edit_user_url(@user)
    end
  end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :action => :index
  end
$end