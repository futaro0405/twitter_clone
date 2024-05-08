# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    bookmark = current_user.bookmarks
    @bookmark_post = Post.where(id: bookmark)
                         .order('created_at DESC')
                         .page(params[:page_bookmarks])
                         .per(5)
  end

  def create
    @post = Post.find(params[:post_id])
    @bookmark = current_user.bookmarks.new(post_id: @post.id)

    if @bookmark.save
      redirect_to request.referer, status: :see_other
    else
      flash.now[:danger] = '失敗'
      render root_path, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @bookmark = current_user.bookmarks.find_by(post_id: @post.id)
    @bookmark.destroy
    redirect_to request.referer, status: :see_other
  end
end
