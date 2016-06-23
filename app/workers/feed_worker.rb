# app/workers/feed_worker.rb
class FeedWorker
  include Sidekiq::Worker

  def perform(id)
    user = User.find(id)
    user.add_to_feed_list
  end
end
