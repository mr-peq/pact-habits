class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def dashboard
    # All user_pacts for the current user:
    @user = current_user
    @user_pacts = current_user.user_pacts

    # And to separate them based on their status:
    @ongoing_pacts = @user_pacts.where(status: :ongoing)
    @achieved_pacts = @user_pacts.where(status: :achieved)
    @failed_pacts = @user_pacts.where(status: :failed)

    @ongoing_pacts_sorted = @ongoing_pacts.sort_by(&:deadline_at).group_by { |user_pact| user_pact.deadline_at.to_date }

    # Key figures:
    @finished_pacts = @user_pacts.where.not(status: :ongoing).count
    @success_rate = @finished_pacts.positive? ? (@achieved_pacts.count.to_f / @finished_pacts) * 100 : 0

    @total_donated = @failed_pacts.sum(&:bet)

    @fill_percentage = (@user.avatar.xp.to_f / @user.avatar.level.to_next).round(3) * 100
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
