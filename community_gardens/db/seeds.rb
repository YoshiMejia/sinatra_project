user_list = {
  "Tim" => {
    :address => "123 Main St",
    :email => "tim@gmail",
    :password_digest => "passwardo"
  },
  "Bob" => {
    :address => "456 sobo ave",
    :email => "bobby@gmail",
    :password_digest => "huhuhu"
  },
  "Hanna" => {
    :address => "123123 south ave",
    :email => "hanbanan@aol",
    :password_digest => "different0"
  },
  "henry" => {
    :address => "990 Spring st",
    :email => "tim@gmail",
    :password_digest => "delta2"
}}

user_list.each do |name, user_hash|
  u = User.new
  u.name = name
  user_hash.each do |attribute, value|
      u[attribute] = value
  end
  u.save
end


plant_list = {
  "Lavender" => {
    :description => "purple, used for medicine",
    :user_id => 1
  },
  "rose" => {
    :description => "pretty red flower",
    :user_id => 4
  },
  "Grass" => {
    :description => "green stuff on lawn",
    :user_id => 2
  },
  "thyme" => {
    :description => "smelly",
    :user_id => 3
}}

plant_list.each do |name, plant_hash|
  p = Plant.new
  p.name = name
  plant_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end