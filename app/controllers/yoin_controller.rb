class YoinController < ApplicationController
  skip_before_action :login_required, only: %i[top]
  def top
    redirect_to home_senryus_url if logged_in?
  end
end
