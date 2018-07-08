class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def logged_in_user
    return false if logged_in?
    store_location
    flash[:danger] = t ".danger"
    redirect_to login_path
  end
end
