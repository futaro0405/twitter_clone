# frozen_string_literal: true

class Comment < ApplicationRecord
  include CreateNotification

  belongs_to :user
  belongs_to :post
  has_many_attached :comment_images
  has_many :notifications, dependent: :destroy
end
