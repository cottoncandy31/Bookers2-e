class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books    
  end

  def edit
    @user = current_user
    user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to user_path(@user.id) 
  end
  end
  
  def index
    @user = current_user
    @users = User.all
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)  
    else
    render :edit
    end
    
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
    redirect_to user_path(current_user.id) 
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
