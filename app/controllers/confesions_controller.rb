class ConfesionsController < ApplicationController
  before_action :set_confesion, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /confesions
  # GET /confesions.json
  def index
    @page = params[:page] || 1
    @confesions = Confesion.order('created_at DESC').paginate(:page => @page, :per_page => 32)
  end

  # GET /confesions/1
  # GET /confesions/1.json
  def show
    if current_user
      @rating = Rating.where(:confesion_id => @confesion.id, :user_id => current_user.id).first
      unless @rating 
           @rating = Rating.create(:confesion_id => @confesion.id, :user_id => current_user.id, :score => 0) 
      end
    end
    page = params[:page] || 1
    @comments = @confesion.comments_list.paginate(:page => page, :per_page => 10)
  end

  # GET /confesions/new
  def new
    @confesion = Confesion.new
    @confesion.image = view_context.confesion_images.sample
  end

  # GET /confesions/1/edit
  def edit
  end

  # GET /confesions/author/:name
  def author
   page = params[:page] || 1
   @author = User.find_by(:username => params[:name])
   @confesions = @author.confesions.where(:anonymous => false).paginate(:page => page, :per_page => 30)
  end

  # POST /confesions
  # POST /confesions.json
  def create
    @confesion = Confesion.new()
    @confesion.tittle = confesion_params[:tittle]
    @confesion.message = confesion_params[:message]
    @confesion.anonymous = confesion_params[:anonymous]
    @confesion.image = confesion_params[:image]
    @confesion.user_id = current_user.id
    respond_to do |format|
      if @confesion.save
        #@confesion.post_to_facebook
        FacebookWorker.perform_async(@confesion.slug)
	#save tags
        confesion_params[:tags].each do |tag|
          unless tag.empty? || tag.nil?
            tmp_tag = Tag.find_or_create_by(name: tag)
            @confesion.tags << tmp_tag
          end
        end
        @confesion.save

        format.html { redirect_to @confesion, notice: 'La confesión fue creada exitosamente.' }
        format.json { render action: 'show', status: :created, location: @confesion }
      else
        format.html { render action: 'new' }
        format.json { render json: @confesion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /confesions/1
  # PATCH/PUT /confesions/1.json
  def update
    respond_to do |format|
      @confesion.tittle = confesion_params[:tittle]
      @confesion.message = confesion_params[:message]
      @confesion.anonymous = confesion_params[:anonymous]
      @confesion.image = confesion_params[:image]
      if @confesion.save
	      #save tags
	      @confesion.tags = []
        confesion_params[:tags].each do |tag|
          tmp_tag = Tag.find_or_create_by(name: tag)
          @confesion.tags << tmp_tag unless (tag.empty? || tag.nil?)
        end
	      @confesion.save

        format.html { redirect_to @confesion, notice: 'Confesion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @confesion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /confesions/1
  # DELETE /confesions/1.json
  def destroy
    @confesion.destroy
    respond_to do |format|
      format.html { redirect_to confesions_url }
      format.json { head :no_content }
    end
  end

  def search
    page = params[:page] || 1
    if params[:text].blank?
      redirect_to confesions_path
      return
    end
    @confesions = Confesion.full_text_search(params[:text]).paginate(:page => page, :per_page => 30)
    render '/confesions/search'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confesion
      @confesion = Confesion.find_by(slug: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def confesion_params
      params.require(:confesion).permit(:tittle, :message, :image, :anonymous, tags: [])
    end
end
