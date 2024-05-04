# frozen_string_literal: true

class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.new(post_id: @post.id)

    if @favorite.save
      redirect_to request.referer, status: :see_other
    else
      flash.now[:danger] = '失敗'
      render root_path, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    @favorite.destroy
    redirect_to request.referer, status: :see_other
  end
end
