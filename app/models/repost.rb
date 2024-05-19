# frozen_string_literal: true

class Repost < ApplicationRecord
  include CreateNotification

  belongs_to :user
  belongs_to :post
end
