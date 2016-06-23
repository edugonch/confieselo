class WeekFeed < ActionMailer::Base
  include TruncateHtmlHelper
  helper_method :truncate_html
  include TagsHelper
  helper_method :tags_list
  default from: Rails.configuration.emails.general_notification


  def send_weekly_feed()
    @confesions = Confesion.where(:created_at.gte => 1.week.ago)
    mail to: Rails.configuration.emails.feed_list, subject: "Confesiones de la semana."
  end
end
