class PactsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @pact = Pact.find(params[:id])
  end

  def edit
    @user_pact = UserPact.find(params[:id])
  end

  def update
    strava_client = StravaClient.new
    @user_pact = UserPact.find(params[:id])
    pact_specs = retrieve_pact_specs

    activity_ids = strava_client.get_user_activities(pact_specs)
    if user_finished_pact(activity_ids)
      redirect_to root_path, notice: "Congrats for your achievement! You've received #{@user_pact.pact.xp} XP"
    else
      redirect_to edit_pact_path(@user_pact), alert: "Looks like you're not quite there yet, champ..."
    end
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

  def retrieve_pact_specs
    category = @user_pact.pact.category
    duration = @user_pact.pact.duration
    distance = @user_pact.pact.distance
    pact_creation = @user_pact.deadline_at.to_i
    duration *= 60 unless duration.nil?     # => convert in seconds for strava
    distance *= 1000 unless distance.nil?   # => convert in meters for strava
    { category:, duration:, distance:, pact_creation: }
  end

  def user_finished_pact(activity_ids)
    activity_ids.each do |activity_id|
      if !current_user.checked_strava_ids.include?(activity_id)
        current_user.checked_strava_ids << activity_id
        current_user.achieved_pacts += 1
        current_user.total_xp += @user_pact.pact.xp
        @user_pact.status = 1
        @user_pact.save
        current_user.save
        return true
      end
    end
    false
  end
end
