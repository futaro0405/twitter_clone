# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @post = Post.all.page(params[:page]).per(10)
  end
end
