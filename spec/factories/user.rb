Factory.define :user do |u|
  u.password "tttttt"
end

Factory.sequence :email do |n|
  "toward7seas0#{n}@gmail.com"
end

Factory.sequence :name do |n|
  "c#{n}"
end

base_name = "user0"
users_size = 4
(1..users_size).each do |i|
  Factory.define((base_name + i.to_s).to_sym, :parent => :user) do |u|
    u.name Factory.next(:name)
    u.email Factory.next(:email)
  end
end