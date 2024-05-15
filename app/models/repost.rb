# frozen_string_literal: true

class Repost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def create_notification_repost!(current_user, post)
    temp_1 = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ? ',
                            current_user.id, post.user_id, post_id, 'repost'])
    return if temp_1.present?

    notification = current_user.active_notifications.new(
      post_id: post_id,
      visited_id: post.user_id,
      action: 'repost'
    )
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
