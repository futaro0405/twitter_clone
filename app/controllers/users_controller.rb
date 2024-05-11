# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show followings followers]
  before_action :set_user

  def show
    posts = @user.posts
    favorites = @user.favorites
    reposts = @user.reposts
    comments = @user.comments

    @my_posts = posts.order('created_at DESC')
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

    @current_entry = Entry.where(user_id: current_user.id).pluck(:room_id)
    @another_entry = Entry.where(user_id: @user.id).pluck(:room_id)
    room_entry = @current_entry & @another_entry

    return if @user.id == current_user.id

    if room_entry.empty?
      @room = Room.new
      @entry = Entry.new
    else
      @is_room = true
      @room_id = room_entry.first
    end
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
