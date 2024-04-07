# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(10)
    @post_follow = Post.all.page(params[:page]).per(10)
    @post = Post.new
  end
end
