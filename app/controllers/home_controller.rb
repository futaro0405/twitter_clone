# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page_all]).per(10)
    if current_user.followings.present?
      @followers = current_user
    else
      @followers = current_user.followings
    end
    @post_follow = Post.where(user_id: @followers).order("created_at DESC").page(params[:page_follow]).per(10)
    @post = Post.new
  end
end
