# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    checked_notification = @notifications.where(checked: false)
    checked_notification.update_all(checked: true)
  end
end
