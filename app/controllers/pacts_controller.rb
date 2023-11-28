class PactsController < ApplicationController
  def index
  end

  def show
    @user_pact = UserPact.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def join
  end
end
