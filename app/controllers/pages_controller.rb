class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def dashboard
    # All user_pacts for the current user:
    @user_pacts = current_user.user_pacts
    @user = current_user

    # And to separate them based on their status:
    @ongoing_pacts = @user_pacts.where(status: :ongoing)
    @achieved_pacts = @user_pacts.where(status: :achieved)
    @failed_pacts = @user_pacts.where(status: :failed)
  end

  def account
    @user = current_user
    @user_pacts = @user.user_pacts
  end

  # def strava_token
  #   params[:code]
  #   raise
  # end
end
