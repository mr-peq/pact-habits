puts "Clearing database..."

UserPact.destroy_all
UserBadge.destroy_all
Badge.destroy_all
Beneficiary.destroy_all
Pact.destroy_all
User.destroy_all
Level.destroy_all
Avatar.destroy_all
Skill.destroy_all

# ============================= USERS ==================================
puts "Creating 3 BOSS users..."

theodore = {
  email: "theodore1712@yahoo.fr",
  password: 123456,
  first_name: "Théodore",
  last_name: "Saulnier",
  birthday: Time.new(1995, 12, 17),
  nickname: "mr-peq",
  strava_token: "",
  total_xp: 0,
  achieved_pacts: 0,
  failed_pacts: 0
}
ismael = {
  email: "ismael.sentissi@gmail.com",
  password: 123456,
  first_name: "Ismaël",
  last_name: "Sentissi",
  birthday: Time.new(1994, 9, 16),
  nickname: "sentouss",
  strava_token: "",
  total_xp: 0,
  achieved_pacts: 0,
  failed_pacts: 0
}
joseph = {
  email: "josephlugand@proton.me",
  password: 123456,
  first_name: "Joseph",
  last_name: "Lugand",
  birthday: Time.new(1987, 1, 6),
  nickname: "jolu",
  strava_token: "",
  total_xp: 0,
  achieved_pacts: 0,
  failed_pacts: 0
}

user_theodore = User.create!(theodore)
user_ismael = User.create!(ismael)
user_joseph = User.create!(joseph)

theodore_url = "https://avatars.githubusercontent.com/u/141660300?v=4"
ismael_url = "https://avatars.githubusercontent.com/u/29755099?v=4}"
joseph_url = "https://avatars.githubusercontent.com/u/145439534?v=4"
ismael_avatar_picture_url = "https://i.pinimg.com/736x/58/20/fe/5820fe42115912f3e21d6588c6d6637f.jpg"
theodore_avatar_picture_url = "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/96f49e5d-b3ae-4ab5-811e-6d11efa2c445/d8duzka-9b898560-1a0c-49c5-996e-2e75970329de.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzk2ZjQ5ZTVkLWIzYWUtNGFiNS04MTFlLTZkMTFlZmEyYzQ0NVwvZDhkdXprYS05Yjg5ODU2MC0xYTBjLTQ5YzUtOTk2ZS0yZTc1OTcwMzI5ZGUucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.UbN9_vPuoTQE3qplAo9BhgKyeyjkhLDx48_ZYKRPQuQ"
joseph_avatar_picture_url = "https://pbs.twimg.com/profile_images/1589659852271280128/KhrL02UB_400x400.jpg"

user_ismael.photo.attach(io: URI.open(ismael_url), filename: 'photo.jpg')
user_theodore.photo.attach(io: URI.open(theodore_url), filename: 'photo.jpg')
user_joseph.photo.attach(io: URI.open(joseph_url), filename: 'photo.jpg')

user_ismael.avatar_picture.attach(io: URI.open(ismael_avatar_picture_url), filename: 'ismael-avatar-picture.jpg')
user_theodore.avatar_picture.attach(io: URI.open(theodore_avatar_picture_url), filename: 'theodore-avatar-picture.jpg')
user_joseph.avatar_picture.attach(io: URI.open(joseph_avatar_picture_url), filename: 'joseph-avatar-picture.jpg')


# ============================= AVATARS & LEVELS ==================================
puts "Creating levels..."
# for details about the calculation, see : https://blog.jakelee.co.uk/converting-levels-into-xp-vice-versa/
i = 0
x = 0.11
y = 2
10.times do
  i += 1
  Level.create!(current: i, to_next: ((i / x)**y))
end

puts "Creating avatars for them BOSSES..."
avatar_theodore = Avatar.new(user: user_theodore, level: Level.first)
avatar_ismael = Avatar.new(user: user_ismael, level: Level.first)
avatar_joseph = Avatar.new(user: user_joseph, level: Level.first)

puts "Creating 12 skills..."
# Min dmg: 15
# Max dmg: 50
Skill.create!(name: 'Low-kick', category: 'physical', dmg: 30)
Skill.create!(name: 'Drunk Boxing', category: 'physical', dmg: 50)
Skill.create!(name: 'Sneak Attack', category: 'physical', dmg: 20)
Skill.create!(name: 'Arm Lock', category: 'physical', dmg: 35)
Skill.create!(name: 'Nudge', category: 'physical', dmg: 25)
Skill.create!(name: 'Fire Blast', category: 'magic', dmg: 45)
Skill.create!(name: 'Icy breath', category: 'magic', dmg: 30)
Skill.create!(name: 'Storm', category: 'magic', dmg: 40)
Skill.create!(name: 'Bloodboil', category: 'magic', dmg: 20)
Skill.create!(name: 'Focus Lotus', category: 'boost')
Skill.create!(name: 'Mana Boost', category: 'boost')
Skill.create!(name: 'On The Look-out', category: 'boost')

puts "Learning some skills to the avatars..."

3.times do
  skill = Skill.all.sample
  while avatar_theodore.skills.include?(skill)
    skill = Skill.all.sample
  end
  AvatarSkill.create!(avatar: avatar_theodore, skill: skill)
end
3.times do
  skill = Skill.all.sample
  while avatar_ismael.skills.include?(skill)
    skill = Skill.all.sample
  end
  AvatarSkill.create!(avatar: avatar_ismael, skill: skill)
end
3.times do
  skill = Skill.all.sample
  while avatar_joseph.skills.include?(skill)
    skill = Skill.all.sample
  end
  AvatarSkill.create!(avatar: avatar_joseph, skill: skill)
end

# ============================= BENEFICIARIES ==================================
puts "Creating beneficiaries..."
Beneficiary.create!(name: "Amnesty International")
Beneficiary.create!(name: "Medecins Sans Frontières")
Beneficiary.create!(name: "Action Contre La Faim")

# ============================= PACTS & CHALLENGES ==================================
puts "Creating 8 new user pacts and 2 challenges..."

CATEGORIES = %w[ride run walk swim]
DISTANCES = [10, 20, 30]    # => km
DURATION = [30, 60, 90]    # => min
WEEKDAYS_ARRAY = [0, 1, 2, 3, 4, 5, 6]
XPS = [30, 50, 80]
COMPLETION_DURATIONS = [1, 2, 3]     # => weeks
BETS = [5, 10, 20, 50]

# Helper function to get random pact stats
def random_pact_stats(challenge)
  if rand > 0.5
    distance = DISTANCES.sample
    duration = nil
  else
    duration = DURATION.sample
    distance = nil
  end

  if rand > 0.5
    recurring = true
    weekdays = []
    rand(1..6).times do
      weekdays << (WEEKDAYS_ARRAY.sample)
    end
    weekdays = weekdays.uniq.sort
  else
    recurring = false
    weekdays = nil
  end

  xp = XPS.sample
  completion_duration = nil

  if challenge
    xp *= 2
    completion_duration = COMPLETION_DURATIONS.sample
  end
  { category: CATEGORIES.sample, distance: distance, duration: duration, recurring: recurring, weekdays: weekdays, xp: xp, challenge: challenge, completion_duration: completion_duration }
end

12.times do
  Pact.create!(random_pact_stats(false))
end

2.times do
  Pact.create!(random_pact_stats(true))
end

# ============================= USER_PACTS ==================================
puts "Binding pacts to users..."

# Ongoing
i = Pact.first.id
4.times do
  pact = Pact.find(i)
  deadline_at = pact.recurring ? Time.now + (7 * 24 * 3600) : Time.now + (rand(2..12) * 3600)

  UserPact.create!(
    user: User.all.sample,
    pact: pact,
    deadline_at: deadline_at,
    bet: BETS.sample,
    beneficiary: Beneficiary.all.sample,
    status: 0
  )
  i += 1
end

# Achieved
4.times do
  pact = Pact.find(i)
  user = User.all.sample
  while user.first_name == "Ismaël"
    user = User.all.sample
  end

  UserPact.create!(
    user: user,
    pact: pact,
    deadline_at: Time.now - (rand(1..30) * rand(0..24) * 3600),
    bet: BETS.sample,
    beneficiary: Beneficiary.all.sample,
    status: 1
  )
  i += 1
end

# Failed
4.times do
  pact = Pact.find(i)
  UserPact.create!(
    user: User.all.sample,
    pact: pact,
    deadline_at: Time.now - (rand(1..30) * rand(0..24) * 3600),
    bet: BETS.sample,
    beneficiary: Beneficiary.all.sample,
    status: 2
  )
  i += 1
end

# Challenges
2.times do
  pact = Pact.find(i)
  UserPact.create!(
    user: User.find_by(first_name: "Théodore"),
    pact: pact,
    deadline_at: Time.now - (rand(1..30) * rand(0..24) * 3600),
    bet: BETS.sample,
    beneficiary: Beneficiary.all.sample,
    status: 1
  )
  if i % 2
    deadline_at = pact.recurring ? Time.now + (7 * 24 * 3600) : Time.now + (rand(2..12) * 3600)
    UserPact.create!(
      user: User.find_by(first_name: "Joseph"),
      pact: pact,
      deadline_at: deadline_at,
      bet: BETS.sample,
      beneficiary: Beneficiary.all.sample,
      status: 0
    )
  end
  i += 1
end


# ============================= SUGGESTED CHALLENGES ==================================

puts "Creating 4 new suggested challenges..."

4.times do
  Pact.create!(random_pact_stats(true))
end

# ============================= BADGES ==================================
puts "Creating Badges..."

Badge.create!(name: "Welcome To The Club", description: "Achieve 1 pact", category: "pacts")
Badge.create!(name: "Just Getting Started", description: "Achieve 5 pacts", category: "pacts")
Badge.create!(name: "Getting Fit", description: "Achieve 10 pacts", category: "pacts")
Badge.create!(name: "Pacting-it-out", description: "Achieve 20 pacts", category: "pacts")
Badge.create!(name: "Sweat = Success", description: "Achieve 50 pacts", category: "pacts")
Badge.create!(name: "Pact-man", description: "Achieve 100 pacts", category: "pacts")
Badge.create!(name: "Ambitions Of A Rider", description: "Ride a total of 50 km", category: "ride")
Badge.create!(name: "Tour De France", description: "Ride a total of 10 hours", category: "ride")
Badge.create!(name: "Slowly But Surely", description: "Walk a total of 50 km", category: "walk")
Badge.create!(name: "Turtle-Person", description: "Walk a total of 10 hours", category: "walk")
Badge.create!(name: "Mermaid", description: "Swim a total of 50 km", category: "swim")
Badge.create!(name: "Yellow Submarine", description: "Swim a total of 10 hours", category: "swim")
Badge.create!(name: "Marathon", description: "Run a total of 50 km", category: "run")
Badge.create!(name: "Forrest Gump", description: "Run a total of 10 hours", category: "run")


# ============================= CUSTOM PACTS FOR ISMAEL ==================================
puts "Creating custom pacts for Ismaël..."

ismael = User.find_by(first_name: "Ismaël")

pact_1 = Pact.create!(category: "ride", distance: 20, xp: 80)
pact_2 = Pact.create!(category: "ride", distance: 20, xp: 80)
pact_3 = Pact.create!(category: "ride", duration: 140, xp: 100)
pact_4 = Pact.create!(category: "walk", distance: 14, xp: 30)
pact_5 = Pact.create!(category: "walk", duration: 90, xp: 45)
pact_6 = Pact.create!(category: "run", duration: 60, xp: 30)
pact_7 = Pact.create!(category: "run", distance: 21, xp: 135)
pact_8 = Pact.create!(category: "run", duration: 80, xp: 70)
pact_9 = Pact.create!(category: "run", duration: 260, xp: 200)
pact_10 = Pact.create!(category: "run", duration: 100, xp: 55)

ongoing_pact_1 = { pact: Pact.create!(category: "run", duration: 120, xp: 90), deadline_at: Time.now + (3 * 24 * 3600) }
ongoing_pact_2 = { pact: Pact.create!(category: "run", distance: 20, xp: 150), deadline_at: Time.now + (5 * 24 * 3600) + ( 4 * 3600) }
ongoing_pact_3 = { pact: Pact.create!(category: "swim", duration: 90, xp: 60), deadline_at: Time.now + (5 * 24 * 3600) + ( 12 * 3600) }
ongoing_pacts = [ongoing_pact_1, ongoing_pact_2, ongoing_pact_3]

ismael_pacts = [pact_1, pact_2, pact_3, pact_4, pact_5, pact_6, pact_7, pact_8, pact_9, pact_10]

ismael_pacts.each do |pact|
  UserPact.create!(
    user: ismael,
    pact: pact,
    deadline_at: Time.now - (rand(1..30) * rand(0..24) * 3600),
    bet: BETS.sample,
    beneficiary: Beneficiary.all.sample,
    status: 1
  )
end

ongoing_pacts.each do |pact|
  UserPact.create!(
    user: User.find_by(first_name: "Ismaël"),
    pact: pact[:pact],
    deadline_at: pact[:deadline_at],
    bet: BETS.sample,
    beneficiary: Beneficiary.all.sample,
    status: 0
  )
end

UserBadge.create!(
  badge: Badge.find_by(name: "Welcome To The Club"),
  user: ismael,
  claimed: true
)

UserBadge.create!(
  badge: Badge.find_by(name: "Just Getting Started"),
  user: ismael,
  claimed: true
)

UserBadge.create!(
  badge: Badge.find_by(name: "Getting Fit"),
  user: ismael,
  claimed: true
)


# ============================= USERS STATS ==================================

puts "Calculating users' XP and stats..."

User.all.each do |user|
  temp_user = user
  avatar = temp_user.avatar
  temp_user.user_pacts.where(status: "achieved").each do |achieved_pact|
    temp_user.total_xp += achieved_pact.pact.xp
    avatar.xp += achieved_pact.pact.xp
    if avatar.xp > avatar.level.to_next
      remain = avatar.xp - avatar.level.to_next
      next_level = avatar.level.current + 1
      avatar.level = Level.find_by(current: next_level)
      avatar.upgrade_points += 2
      avatar.xp = remain
    end
    avatar.save
    temp_user.achieved_pacts += 1
  end
  temp_user.user_pacts.where(status: "failed").each do
    temp_user.failed_pacts += 1
  end
  temp_user.save
end

puts "Done"
