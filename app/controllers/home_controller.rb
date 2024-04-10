# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Post.includes(:user).page(params[:page]).per(10).order("created_at DESC")
    @post_follow = Post.includes(:user).page(params[:page]).per(10).order("created_at DESC")
    @post = Post.new
  end
end
