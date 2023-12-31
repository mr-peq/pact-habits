class AvatarController < ApplicationController
  before_action :authenticate_user!

  def show
    @avatar = Avatar.find(params[:id])
    @missing_skills = Skill
      .joins("LEFT JOIN avatar_skills ON skills.id = avatar_skills.skill_id AND avatar_skills.avatar_id = #{@avatar.id}")
      .where("avatar_skills.skill_id IS NULL")
    @fill_percentage = (@avatar.xp.to_f / @avatar.level.to_next).round(3) * 100
    @user_badges = current_user.user_badges.where(claimed: false)
    @missing_badges = Badge
      .joins("LEFT JOIN user_badges ON badges.id = user_badges.badge_id AND user_badges.user_id = #{current_user.id}")
      .where("user_badges.badge_id IS NULL")
    @my_badges = current_user.user_badges.where(claimed: true).map(&:badge)
    @all_badges_count = Badge.all.count

    @user = current_user
    @current_user_rank = User.where('total_xp > ?', current_user.total_xp).count + 1
  end

  def update
    user_badge = UserBadge.new(claimed: true)
    badge = Badge.find(params[:avatar][:badge_id])
    user_badge.user = current_user
    user_badge.badge = badge

    if user_badge.save
      UserBadge.where(user: current_user).where(badge: badge).find_by(claimed: false).destroy
      @my_badges = current_user.user_badges.where(claimed: true).map(&:badge)
      respond_to do |format|
        format.json { render json: { html: render_to_string(partial: "avatar/my_badges", locals: { my_badges: @my_badges }, formats: :html) } }
      end
    else
      redirect_to avatar_path(self)
    end

    # if user_badge.save
    #   UserBadge.where(user: current_user).where(badge: badge).find_by(claimed: false).destroy
    #   @my_badges = current_user.user_badges.where(claimed: true).map(&:badge)
    #   # redirect_to avatar_path(self)
    # else
    #   redirect_to avatar_path(self)
    # end

    # @avatar = Avatar.find(params[:id])
    # response = JSON.parse(request.body.read)
    # stats = response["stats"]
    # stats.each do |key, value|
    #   @avatar[key] = value
    # end
    # @avatar.upgrade_points = 0
    # @avatar.save
    # respond_to do |format|
    #   format.json { render json: { html: render_to_string(partial: "avatar/stats_and_skills", locals: { avatar: @avatar}, formats: :html) } }
    # end
  end
end
