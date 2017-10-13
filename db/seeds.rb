

100.times do |i|
  name = "ユーザー" + i.to_s
  mail = i.to_s + "@google.com"
  User.create(name: name, mail: mail)
end
