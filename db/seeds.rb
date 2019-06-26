20.times do
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
                email: email,
                bio: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam", 
                password: password,
                password_confirmation: password)
end

senryus =[
  ["あきふかき", "となりはなにを", "するひとぞ"], 
  ["さみだれを", "あつめてはやし", "もがみがわ"], 
  ["あらふたと", "あおばわかばの", "ひのひかり"], 
  ["うぐいすや", "やなぎのうしろ", "やぶのまえ"], 
  ["しばらくは", "はなのうえなる", "つきよかな"], 
  ["おもしろや", "ことしのはるも", "たびのそら"], 
  ["うかれける", "ひとやはつせの", "やまざくら"], 
  ["しずけさや", "いわにしみいる", "せみのこえ"], 
  ["さみだれの", "ふりのこしてや", "ひかりどう"], 
  ["ふるいけや", "かわずとびこむ", "みずのおと"], 
  ["くものみね", "いくつくずれて", "つきのやま"], 
  ["すずしさや", "ほのみかづきの", "はぐろさん"], 
  ["まつかぜの", "おちばかみずの", "おとすずし"], 
  ["めいづきや", "いけをめぐりて", "よもすがら"], 
  ["あきかぜの", "ふけどもあおし", "くりのたま"], 
  ["おもかげや", "うばひとりなく", "つきのとも"], 
  ["このみちを", "いくひとなしに", "あきのくれ"], 
  ["はつゆきや", "すいせんのはの", "たわむまで"], 
  ["はこねこす", "ひともあるらし", "けさのゆき"], 
  ["なかなかに", "こころをかしき", "しわすかな"]]

i = 1
senryus.each do |arr|
  Senryu.create(first_line: arr[0], second_line: arr[1], third_line: arr[2], user_id: i)
  i += 1
end

20.times do |n|
  n += 1
  if n == 1
    ids = (2..20).to_a
  elsif n == 20
    ids = (1..19).to_a
  else
    ids = (1..20).to_a
    ids.delete(n)
  end
  three_ids = ids.sample(3)
  
  Favorite.create(user_id: n, senryu_id: three_ids[0])
  Favorite.create(user_id: n, senryu_id: three_ids[1])
  Favorite.create(user_id: n, senryu_id: three_ids[2])

  Relationship.create(follower_id: n, followed_id: three_ids[0])
  Relationship.create(follower_id: n, followed_id: three_ids[1])
  Relationship.create(follower_id: n, followed_id: three_ids[2])
end

# 20.times do |n|
#   n += 1
#   if n == 1
#     ids = (2..20).to_a
#   elsif n == 20
#     ids = (1..19).to_a
#   else
#     ids = (1..20).to_a
#     ids.delete(n)
#   end
#   three_ids = ids.sample(3)
#   Relationship.create(follower_id: n, followed_id: three_ids[0])
#   Relationship.create(follower_id: n, followed_id: three_ids[1])
#   Relationship.create(follower_id: n, followed_id: three_ids[2])
# end