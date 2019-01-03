class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:show, :edit, :update]

  def show
  end

  def edit

  end

  def update
    if @user.update(user_params)
      @user.avatar.attach(user_params[:avatar]) if user_params[:avatar]
      @user.save
      redirect_to user_path(@user)
    else
      redirect_to edit_user_path(@user)
    end
  end
  
  private
    def authenticate_user!
      if current_user != @user && !current_user.superadmin
        redirect_to root_path
      end
    end

    def set_user
      @user = User.find_by_id(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :avatar)
    end
end
