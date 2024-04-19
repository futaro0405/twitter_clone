# frozen_string_literal: true

class RelationshipsController < ApplicationController
  # フォロー処理
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  # フォローを外す処理
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
