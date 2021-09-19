user_list = {
  "Tim" => {
    :address => "123 Main St"
  },
  "Bob" => {
    :address => "456 sobo ave"
  },
  "Hanna" => {
    :address => "123123 south ave"
  },
  "henry" => {
    :address => "990 Spring st"
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
    :description => "purple, used for medicine"
  },
  "rose" => {
    :description => "pretty red flower"
  },
  "Grass" => {
    :description => "green stuff on lawn"
  },
  "thyme" => {
    :description => "smelly"
}}

plant_list.each do |name, plant_hash|
  p = Plant.new
  p.name = name
  plant_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end