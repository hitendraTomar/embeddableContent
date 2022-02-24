class ContentsController < ApplicationController
  before_action :authenticate_user!

  before_action :get_content, except: [:index, :new, :create]

  def index
    @contents = if current_user.publisher?
                  EmbeddableContent.all
                else
                  # current_user.contents
                  EmbeddableContent.where(user_id: current_user.id)
                end
  end

  def new
    @content = EmbeddableContent.new
    @stylsheet = @content.content_stylesheets.build
  end

  def create
    @content = EmbeddableContent.new(content_params)
    if @content.save
      flash[:notice] = "Content Successfully Created"
      redirect_to contents_path
    else
      render :new
    end
  end

  def edit
    @stylsheet = @content.content_stylesheets
  end

  def update
    if @content.update(content_params)
      flash[:notice] = "Content Successfully Updated"
      redirect_to contents_path
    else
      render :edit
    end
  end

  def show
    @stylsheets = @content.content_stylesheets
    if current_user.publisher?
      publisher_stylsheets = @content.by_user
      remaining_stylsheets = publisher_stylsheets - @stylsheets
      @stylsheets = publisher_stylsheets + remaining_stylsheets
    end
  end

  def destroy
    if @content.destroy
      flash[:notice] = "Content Successfully Deleted"
    end
    redirect_to contents_path
  end

  private

  def content_params
    params.require(:embeddable_content).permit(:user_id, :title, :body, :header, :footer,
      content_stylesheets_attributes: [ :name,:body ]
      )
  end

  def get_content
    @content = EmbeddableContent.find_by_id(params[:id])
  end
end
