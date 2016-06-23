# app/workers/facebook_worker.rb
class FacebookWorker
  include Sidekiq::Worker

  def perform(slug)
    confesion = Confesion.find_by(slug: slug)
    confesion.post_to_facebook
  end
end
