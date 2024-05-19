# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user

  add_flash_types :success, :info, :warning, :danger

  def set_current_user
    User.current_user = current_user
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[email password password_confirmation name telephone birth_date profile location website
                     image_avatar image_cover]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
