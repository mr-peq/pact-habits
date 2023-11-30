puts "Clearing database..."

UserPact.destroy_all
Beneficiary.destroy_all
Pact.destroy_all
User.destroy_all

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
avatar_picture_url = "https://www.fightersgeneration.com/np7/char/guy-ffrevenge-bust.png"

user_theodore.photo.attach(io: URI.open(theodore_url), filename: 'photo.jpg')
user_ismael.photo.attach(io: URI.open(ismael_url), filename: 'photo.jpg')
user_joseph.photo.attach(io: URI.open(joseph_url), filename: 'photo.jpg')

user_theodore.avatar_picture.attach(io: URI.open(avatar_picture_url), filename: 'avatar-picture.jpg')
user_ismael.avatar_picture.attach(io: URI.open(avatar_picture_url), filename: 'avatar-picture.jpg')
user_joseph.avatar_picture.attach(io: URI.open(avatar_picture_url), filename: 'avatar-picture.jpg')

# ============================= BENEFICIARIES ==================================
puts "Creating beneficiaries..."
Beneficiary.create!(name: "Amnesty International")
Beneficiary.create!(name: "Medecins Sans Frontières")
Beneficiary.create!(name: "Action Contre La Faim")

# ============================= PACTS & CHALLENGES ==================================
puts "Creating 8 new user pacts and 2 challenges..."

CATEGORIES = %w[cycle run walk hike]
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
  UserPact.create!(
    user: User.all.sample,
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
    user: User.find_by(first_name: "Ismaël"),
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

# ============================= USERS STATS ==================================

puts "Calculating users' XP and stats..."

User.all.each do |user|
  temp_user = user
  temp_user.user_pacts.where(status: "achieved").each do |achieved_pact|
    temp_user.total_xp += achieved_pact.pact.xp
    temp_user.achieved_pacts += 1
  end
  temp_user.user_pacts.where(status: "failed").each do
    temp_user.failed_pacts += 1
  end
  temp_user.save
end

puts "Done"
