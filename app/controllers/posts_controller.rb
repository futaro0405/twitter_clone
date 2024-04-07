class PostsController < ApplicationController
  def create
    @posts = current_user.post.new(post_params)
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
