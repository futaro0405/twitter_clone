# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(10)
    @post_follow = Post.current_user.followings.order("created_at DESC").page(params[:page]).per(10)
    @post = Post.new
  end
end
