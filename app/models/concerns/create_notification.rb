# frozen_string_literal: true

module CreateNotification
  extend ActiveSupport::Concern

  included do
    after_create :create_notification
  end

  def create_notification
    if instance_of?(::Comment)
      temp_ids = post.comments.where(post_id: post.id).where.not(user_id: User.current_user.id).distinct.pluck(:user_id)
      temp_ids.each do |temp_id|
        save_notification(temp_id['user_id'])
      end
      save_notification(post.user_id) if temp_ids.blank?
    else
      temp = Notification.where(
               visitor_id: User.current_user.id,
               visited_id: post.user_id,
               post_id: post_id,
               action: self.class.name
             )
      return if temp.present?

      save_notification(post.user_id)
    end
  end

  def save_notification(visited_user)
    notification = User.current_user.active_notifications.new(
      post_id:,
      visited_id: visited_user,
      action: self.class.name
    )
    notification.update(comment_id: id) if instance_of?(::Comment)
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
