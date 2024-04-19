# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts_all = Post.includes(:user).order('created_at DESC').page(params[:page_all]).per(10)
    @followers = current_user.followings if current_user.present?
    @posts_followers = Post.where(user_id: [current_user,
                                            @followers]).order('created_at DESC').page(params[:page_follow]).per(10)
    @post = Post.new
  end
end
