class AvatarController < ApplicationController
  before_action :authenticate_user!

  def show
    @avatar = Avatar.find(params[:id])
    @missing_skills = Skill
      .joins("LEFT JOIN avatar_skills ON skills.id = avatar_skills.skill_id AND avatar_skills.avatar_id = #{@avatar.id}")
      .where("avatar_skills.skill_id IS NULL")
  end

  def update
    @avatar = Avatar.find(params[:id])
    response = JSON.parse(request.body.read)
    stats = response["stats"]
    stats.each do |key, value|
      @avatar[key] = value
    end
    @avatar.upgrade_points = 0
    @avatar.save
    respond_to do |format|
      format.json { render json: { html: render_to_string(partial: "avatar/stats_and_skills", locals: { avatar: @avatar}, formats: :html) } }
    end
  end
end
