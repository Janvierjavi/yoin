class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper

  before_action :login_required

  private

  def login_required
    unless current_user
      redirect_to new_session_url, notice: I18n.t('controllers.notices.login_required')
    end
  end
end
