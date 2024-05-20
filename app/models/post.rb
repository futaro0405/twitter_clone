# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reposts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :notifications, dependent: :destroy

  belongs_to :user
  has_many_attached :images

  validates :content, length: { maximum: 140 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def reposted_by?(user)
    reposts.exists?(user_id: user.id)
  end

  def bookmark_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(
            visitor_id: current_user.id,
            visited_id: user_id,
            action: 'follow'
           )
    return if temp.present?

    notification = current_user.active_notifications.new(
      visited_id: user_id,
      action: 'follow'
    )
    notification.save if notification.valid?
  end
end
