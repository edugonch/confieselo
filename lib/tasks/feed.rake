namespace :feed do
  desc "TODO"
  task week_feed: :environment do
    WeekFeed.send_weekly_feed.deliver
  end

end
