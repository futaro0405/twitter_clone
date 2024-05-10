# frozen_string_literal: true

class PostsController < ApplicationController
  def show
    @post = Post.find_by(id: params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :desc).page(params[:page_comment]).per(3)
    @comment = current_user.comments.new

    @current_entry = Entry.where(user_id: current_user.id).pluck(:room_id)
    @another_entry = Entry.where(user_id: @post.user.id).pluck(:room_id)

    return if @post.user.id == current_user.id

    @is_room = true
    @room_id = @current_entry & @another_entry

    return if @is_room

    @room = Room.new
    @entry = Entry.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @posts = current_user.posts.new(post_params)

    if @posts.save
      redirect_to root_path, success: 'Postしました。', status: :see_other
    else
      flash.now[:danger] = '失敗'
      render 'home/index', status: :unprocessable_entity
    end
  end

  def update
    post = Post.find(params[:id])
    params[:post][:image_ids]&.each do |image_id|
      image = post.images.find(image_id)
      image.purge
    end
    if post.update(post_params)
      redirect_to root_path, success: '編集しました', status: :see_other
    else
      flash.now[:danger] = '失敗'
      render root_path, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, success: '削除しました', status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
