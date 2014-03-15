class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @user = User.new
    @title= " Sign up "
    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
   
  def edit
    @user = User.find_by_id(params[:id])
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
 
 private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def signed_in_user
    unless signed_in?
      flash[:notice] = "Please sign in bitch"
      redirect_to signin_url
    end
  end
end
