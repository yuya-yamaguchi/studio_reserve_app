class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
    
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :first_name, :last_name, :tel_no, :email, :profile, :img)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
