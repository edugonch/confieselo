class CommentsController < ApplicationController
  prepend_before_filter :get_model
  before_filter :get_comment, :only => [:show, :edit, :update, :destroy]  

  respond_to :html
  
  def index
    @comments = @model.comments
    respond_with([@model,@comment, layout: falses])
  end

  def show
    respond_with([@model,@comment])
  end

  def new
    @comment = Comment.new(comment_params)
    @parent_id = params[:parent_id]
    @tree = params[:tree]
    render layout: false
  end

  def edit
    respond_with([@model,@comment])
  end

  def create
    @comment = @model.create_comment!(comment_params, params[:send_anon_comment], params[:parent_id])
    render :partial => 'comments/comment', :locals => { :comments => [@comment], :tree => params[:tree].to_i }
  end

  def update
    if @comment.update_attributes(comment_params)
      flash[:notice] = 'Comment was successfully updated.'
    else
      flash[:error] = 'Comment wasn\'t deleted.'
    end
    respond_with([@model,@comment], :location => @model)
  end

  def destroy
    @comment.destroy
    respond_with(@model)
  end

  private

  def get_model
    @model = Confesion.find_by(slug: params[:confesion_id])
  end
  
  def get_comment
    @comment = @model.comments.find(params[:id])
  end
  def comment_params
      params.require(:comment).permit(:text, :id, :parent_id)
  end
end
