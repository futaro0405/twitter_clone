# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def create_notification_like!(current_user, post)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ? ', current_user.id,
                               post.user_id, post_id, 'like'])
    return if temp.present?

    notification = current_user.active_notifications.new(
      post_id: post_id,
      visited_id: post.user_id,
      action: 'like'
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
