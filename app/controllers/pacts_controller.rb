class PactsController < ApplicationController
  before_action :authenticate_user!

  def index
    # All user_pacts for the current user:
    @user_pacts = current_user.user_pacts

    # And to separate them based on their status:
    @ongoing_pacts = @user_pacts.where(status: :ongoing).map(&:pact)
    @achieved_pacts = @user_pacts.where(status: :achieved).map(&:pact)
    @failed_pacts = @user_pacts.where(status: :failed).map(&:pact)
  end

  def show
    @user_pact = UserPact.find(params[:id])
  end

  def edit
  end

  def update
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
