
set :environment, :development
# set :cron_log, "/path/to/my/cron_log.log"
#

#  command "/usr/bin/some_great_command"
#  runner "MyModel.some_method"
#  rake "some:great:rake:task"
#  runner "Result.update_all('weight = weight + 1')"


every 1.day do
  runner "User.all.each(&:commute)"
end


# Learn more: http://github.com/javan/whenever
