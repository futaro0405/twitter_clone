class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :name,
      :telephone,
      :birth_date,
      :profile,
      :location,
      :website,
      :image_avatar,
      :image_cover
    )
  end
end
