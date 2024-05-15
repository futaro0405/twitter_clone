# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many_attached :comment_images
  has_many :notifications, dependent: :destroy

  def create_notification_comment!(current_user, post)
    binding.pry
    temp_ids = Comment.select(:user_id).where(post_id: post.id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post.id, id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, post.id, id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, post_id, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: post_id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )

    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
