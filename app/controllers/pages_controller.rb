class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def dashboard
    @pacts = Pact.all
  end

  def account
  end

  # def strava_token
  #   params[:code]
  #   raise
  # end
end
