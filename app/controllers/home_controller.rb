# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts_all = Post.includes(:user).order('created_at DESC').page(params[:page_all]).per(10)
    @followers = current_user.followings if user_signed_in?
    @posts_followers = Post.where(user_id: @followers).order('created_at DESC').page(params[:page_follow]).per(10)
    @post = Post.new
  end
end
