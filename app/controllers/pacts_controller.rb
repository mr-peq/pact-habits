class PactsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
  end

  def edit
    @user_pact = UserPact.find(params[:id])
  end

  def update
    strava_client = StravaClient.new
    @user_pact = UserPact.find(params[:id])
    category = @user_pact.pact.category
    duration = @user_pact.pact.duration
    distance = @user_pact.pact.distance
    duration *= 60 unless duration.nil?     # => convert in seconds for strava
    distance *= 1000 unless distance.nil?   # => convert in meters for strava

    activity_ids = strava_client.get_user_activities({category: category, distance: distance, duration: duration, pact_creation: @user_pact.deadline_at.to_i })
    activity_ids.each do |activity_id|
      if !current_user.checked_strava_ids.include?(activity_id)
        current_user.checked_strava_ids << activity_id
        current_user.achieved_pacts += 1
        current_user.total_xp += @user_pact.pact.xp
        @user_pact.status = 1
        @user_pact.save
        current_user.save
        break
      end
    end
    redirect_to root_path, notice: "Congrats for your achievement! You've received #{@user_pact.pact.xp} XP"
    # iterate over activity_ids
    # Check if user's checked_strava_ids include? activity_id
    # IF true, next
    # ELSE
    # - store activity_id in user.checked_strava_ids
    # - user.achieved_pacts += 1
    # - @user_pact.status = 1 (achieved)
    # - user.total_xp += @user_pact.pact.xp
    # - save @user_pact
    # - save user
  end

  def join
  end

  def new
    @pact = Pact.new
    @user_pact = UserPact.new
    @beneficiaries = Beneficiary.all
  end

  def create
    @pact = Pact.new(pact_params)
    raise
    ActiveRecord::Base.transaction do
      if @pact.save
        # Create the associated UserPact
        @user_pact = UserPact.new(user_pact_params)
        @user_pact.pact = @pact
        @user_pact.user = current_user
        raise
        raise ActiveRecord::Rollback, "UserPact couldn't be created" unless @user_pact.save

        # Redirect to the homepage if successfull
        redirect_to root_path, notice: 'Pact was successfully created.'
      else
        render :new
      end
    end
  rescue ActiveRecord::Rollback
    # If the transaction fails, the render :new will be triggered
    render :new
  end

  private

  # Strong parameters for Pact
  def pact_params
    params.require(:pact).permit(:category, :distance, :duration, :recurring, :weekdays, :beneficiary_id)
  end

  # Strong parameters for UserPact
  def user_pact_params
    params.require(:user_pact).permit(:deadline_at, :bet)
  end
end
