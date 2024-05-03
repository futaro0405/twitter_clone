# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    reposts = Repost.where(user_id: @user.id).pluck(:post_id)
    comments = Comment.where(user_id: @user.id)

    @my_posts = Post.where(user_id: @user)
                    .order('created_at DESC')
                    .page(params[:page_my])
                    .per(5)
    @favorite_post = Post.where(id: favorites)
                         .order('created_at DESC')
                         .page(params[:page_repost])
                         .per(5)
    @repost_post = Post.where(id: reposts)
                       .order('created_at DESC')
                       .page(params[:page_repost])
                       .per(5)
    @comment_post = comments.order('created_at DESC')
                            .page(params[:page_comment])
                            .per(5)
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
