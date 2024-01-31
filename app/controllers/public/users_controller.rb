class Public::UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to mypage_path
  end



  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email, :profile_image)
  end

end
