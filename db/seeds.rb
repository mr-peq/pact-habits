puts "Clearing database..."

UserPact.destroy_all
Pact.destroy_all
User.destroy_all

emails = ["theodore1712@yahoo.fr", "josephlugand@proton.me", "ismael.sentissi@gmail.com"]
theodore = {
  email: "theodore1712@yahoo.fr",
  password: 123456,
  first_name: "Théodore",
  last_name: "Saulnier",
  birthday: Time.new(1995, 12, 17),
  nickname: "mr-peq",
  strava_token: "",
  total_xp: 80,
  achieved_pacts: 3,
  failed_pacts: 2
}
ismael = {
  email: "ismael.sentissi@gmail.com",
  password: 123456,
  first_name: "Ismaël",
  last_name: "Sentissi",
  birthday: Time.new(1994, 9, 16),
  nickname: "sentouss",
  strava_token: "",
  total_xp: 200,
  achieved_pacts: 7,
  failed_pacts: 2
}
joseph = {
  email: "josephlugand@proton.me",
  password: 123456,
  first_name: "Joseph",
  last_name: "Lugand",
  birthday: Time.new(1987, 1, 6),
  nickname: "jolu",
  strava_token: "",
  total_xp: 80,
  achieved_pacts: 3,
  failed_pacts: 2
}

puts "Creating 3 users..."
3.times do
  User.create!('')
end
