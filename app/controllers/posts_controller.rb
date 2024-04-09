class PostsController < ApplicationController
  def create
    @posts = current_user.posts.new(post_params)

    if @posts.save
      redirect_to root_path, notice: 'Postしました。', status: :see_other
    else
      flash.now[:notice] = '失敗'
      render root_path, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
