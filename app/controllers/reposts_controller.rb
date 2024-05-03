class RepostsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @repost = current_user.reposts.new(post_id: @post.id)

    if @repost.save
      redirect_to request.referer, status: :see_other
    else
      flash.now[:danger] = '失敗'
      render root_path, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @repost = current_user.favorites.find_by(post_id: @post.id)
    @repost.destroy
    redirect_to request.referer, status: :see_other
  end
end
