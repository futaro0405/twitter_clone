# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to request.referer, success: 'commentしました。', status: :see_other
    else
      flash.now[:danger] = '失敗'
      render root_path, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :comment_images)
  end
end
