# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @post = Post.where(user_id: @user).order('created_at DESC')
    @my_posts = @post.page(params[:page_my]).per(10)
    @posts_favorite = @post.page(params[:page_favorite]).per(10)
    @posts_repost = @post.page(params[:page_repost]).per(10)
    @posts_comment = @post.page(params[:page_comment]).per(10)
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
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
