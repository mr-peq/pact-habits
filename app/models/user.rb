class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :sort_pacts

  has_many :user_badges
  has_many :badges, through: :user_badges
  has_many :user_pacts
  has_many :pacts, through: :user_pacts
  has_one :avatar, dependent: :destroy

  has_one_attached :photo
  has_one_attached :avatar_picture

  def sort_pacts
    achieved_pacts = user_pacts.where(status: "achieved").map(&:pact)
    ride_pacts = get_specific_pacts(achieved_pacts, "ride")
    walk_pacts = get_specific_pacts(achieved_pacts, "walk")
    hike_pacts = get_specific_pacts(achieved_pacts, "hike")
    run_pacts = get_specific_pacts(achieved_pacts, "run")
    assign_badges(achieved_pacts:, ride_pacts:, walk_pacts:, hike_pacts:, run_pacts:)
  end

  def get_specific_pacts(pacts, category)
    pacts.select { |pact| pact.category == category }
  end

  def assign_badges(args = {})
    assign_walk_badges(args[:walk_pacts])
    assign_hike_badges(args[:hike_pacts])
    assign_run_badges(args[:run_pacts])
    assign_ride_badges(args[:ride_pacts])
    assign_pact_badges(args[:achieved_pacts])
  end

  def assign_walk_badges(walk_pacts)
    total_duration = 0
    total_distance = 0
    walk_pacts.each do |pact|
      total_distance += pact.distance unless pact.distance.nil?
      total_duration += pact.duration unless pact.duration.nil?
    end
    if total_distance >= 50
      badge = Badge.find_by(name: "Slowly But Surely")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Slowly But Surely")
    end
    if total_duration >= 600
      badge = Badge.find_by(name: "Turtle-Person")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Turtle-Person")
    end
  end

  def assign_hike_badges(hike_pacts)
    total_duration = 0
    total_distance = 0
    hike_pacts.each do |pact|
      total_distance += pact.distance unless pact.distance.nil?
      total_duration += pact.duration unless pact.duration.nil?
    end
    if total_distance >= 50
      badge = Badge.find_by(name: "Hiker")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Hiker")
    end
    if total_duration >= 600
      badge = Badge.find_by(name: "I Live In The Mountains")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "I Live In The Mountains")
    end
  end

  def assign_run_badges(run_pacts)
    total_duration = 0
    total_distance = 0
    run_pacts.each do |pact|
      total_distance += pact.distance unless pact.distance.nil?
      total_duration += pact.duration unless pact.duration.nil?
    end
    if total_distance >= 50
      badge = Badge.find_by(name: "Marathon")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Marathon")
    end
    if total_duration >= 600
      badge = Badge.find_by(name: "Forrest Gump")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Forrest Gump")
    end
  end

  def assign_ride_badges(ride_pacts)
    total_duration = 0
    total_distance = 0
    ride_pacts.each do |pact|
      total_distance += pact.distance unless pact.distance.nil?
      total_duration += pact.duration unless pact.duration.nil?
    end
    if total_distance >= 50
      badge = Badge.find_by(name: "Ambitions Of A Rider")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Ambitions Of A Rider")
    end
    if total_duration >= 600
      badge = Badge.find_by(name: "Tour De France")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Tour De France")
    end
  end

  def assign_pact_badges(achieved_pacts)
    if achieved_pacts.count > 0
      badge = Badge.find_by(name: "Welcome To The Club")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Welcome To The Club")
    end
    if achieved_pacts.count >= 5
      badge = Badge.find_by(name: "Just Getting Started !")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Just Getting Started !")
    end
    if achieved_pacts.count >= 10
      badge = Badge.find_by(name: "Getting Fit")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Getting Fit")
    end
    if achieved_pacts.count >= 20
      badge = Badge.find_by(name: "Pacting-it-out")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Pacting-it-out")
    end
    if achieved_pacts.count >= 50
      badge = Badge.find_by(name: "Sweat = Success")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Sweat = Success")
    end
    if achieved_pacts.count >= 100
      badge = Badge.find_by(name: "Pact-man")
      UserBadge.create!(user: self, badge: badge) unless badges.exists?(name: "Pact-man")
    end
  end
end
