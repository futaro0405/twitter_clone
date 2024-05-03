# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show followings followers]
  before_action :set_user

  def show
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
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

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
