class AvatarController < ApplicationController
  before_action :authenticate_user!

  def show
    @avatar = Avatar.find(params[:id])
    @missing_skills = Skill
      .joins("LEFT JOIN avatar_skills ON skills.id = avatar_skills.skill_id AND avatar_skills.avatar_id = #{@avatar.id}")
      .where("avatar_skills.skill_id IS NULL")
  end
end
