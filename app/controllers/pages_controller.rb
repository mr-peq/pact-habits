class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :dashboard ]

  def next_occurrence_date(user_pact)
    return user_pact.deadline_at.to_date unless user_pact.pact.recurring

    today = Date.today
    weekdays = user_pact.pact.weekdays.map(&:to_i).sort
    next_occurrences = weekdays.map do |weekday|
      difference = weekday - today.wday + 1
      difference += 6 if difference.negative?
      today + difference.days
    end

    next_occurrence = next_occurrences.select { |date| date <= user_pact.deadline_at.to_date }.min
    next_occurrence || user_pact.deadline_at.to_date
  end

  def leaderboard
    @top_users = User.order(total_xp: :desc).limit(3)
    @current_user_rank = User.where('total_xp > ?', current_user.total_xp).count + 1
  end

  def dashboard
    # All user_pacts for the current user:
    @user = current_user
    @user_pacts = current_user.user_pacts
    @avatar = current_user.avatar

    # And to separate them based on their status:
    @ongoing_pacts = @user_pacts.where(status: :ongoing)
    @achieved_pacts = @user_pacts.where(status: :achieved)
    @failed_pacts = @user_pacts.where(status: :failed)

    @ongoing_pacts_sorted = @ongoing_pacts.each_with_object({}) do |user_pact, grouped_pacts|
      date = next_occurrence_date(user_pact)
      (grouped_pacts[date] ||= []) << user_pact
    end

    @ongoing_pacts_sorted = @ongoing_pacts_sorted.sort_by { |date, _| date }.to_h

    # @ongoing_pacts_sorted = @ongoing_pacts.sort_by(&:deadline_at).group_by { |user_pact| user_pact.deadline_at.to_date }

    # Key figures:
    @finished_pacts = @user_pacts.where.not(status: :ongoing).count
    @success_rate = @finished_pacts.positive? ? (@achieved_pacts.count.to_f / @finished_pacts) * 100 : 0

    @total_donated = @failed_pacts.sum(&:bet)
    @total_ongoing_bet = @ongoing_pacts.sum(&:bet)

    @fill_percentage = (@user.avatar.xp.to_f / @user.avatar.level.to_next).round(3) * 100

    @top_users = User.order(total_xp: :desc).limit(3)
    @current_user_rank = User.where('total_xp > ?', current_user.total_xp).count + 1
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
