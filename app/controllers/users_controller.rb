# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show followings followers]
  before_action :set_user

  def show
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)

    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end

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
