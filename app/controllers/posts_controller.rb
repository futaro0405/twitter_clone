class PostsController < ApplicationController
  def edit
    @post = Post.find(params[:id])
  end

  def create
    @posts = current_user.posts.new(post_params)

    if @posts.save
      redirect_to root_path, success: 'Postしました。', status: :see_other
    else
      flash.now[:danger] = '失敗'
      render root_path, status: :unprocessable_entity
    end
  end

  def update
    post = Post.find(params[:id])
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = post.images.find(image_id)
        image.purge
      end
    end
    if post.update_attributes(post_params)
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
