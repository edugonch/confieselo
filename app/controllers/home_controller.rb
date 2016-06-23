class HomeController < ApplicationController
  def legal
    render layout: false
  end

  def terms
    render layout: false
  end

  def sitemap
    @confesions = Confesion.all
    @tags = Tag.all
  end

  def robots
    render "robots.txt", layout: false, content_type: "text/plain"
  end

end
