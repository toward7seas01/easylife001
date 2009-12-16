namespace :db do
  desc "rebuild all database"
  task :rad do
    system("rake db:drop:all")
    system("rake db:create:all")
    system("rake db:migrate")
    system("rake db:test:clone_structure")
  end
end

namespace :db do
  desc "rebuild all database and data"
  task :r => :rad do
    system("rake db:seed")
  end
end

namespace :db do
  desc "extra seed data"
  task :e do
    exec("script/runner db/seeds2.rb")
  end
end


task :g do
  tag = STDIN.gets()
  system("git add .")
  system("git commit -a -m #{tag}")
  system("git tag #{tag}")
  system("git status")
end

task :send_email => :environment do
  user = User.find ENV["USER_ID"]
  OrderMailer.deliver_confirm(user)
end


