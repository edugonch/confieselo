class TagsController < ApplicationController
  # GET /tags
  # GET /tags.json
  def index
    if params[:query]
      @tags = Tag.full_text_search(params[:query])
    else
      @tags = Tag.all
    end
  end

  def show
    page = params[:page] || 1
    @tag = Tag.find_by(:name => params[:id])
    @confesions = @tag.confesions.paginate(:page => page, :per_page => 30)
  end
end
