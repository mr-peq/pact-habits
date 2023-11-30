class AvatarController < ApplicationController
  before_action :authenticate_user!

  def show
    @avatar = Avatar.find(params[:id])
  end
end
