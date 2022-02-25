class ContentsController < ApplicationController
  before_action :authenticate_user!

  before_action :get_content, except: [:index, :new, :create]

  # load_and_authorize_resource class: EmbeddableContent

  def index
    @contents = if current_user.publisher?
                  EmbeddableContent.all.reverse
                else
                  EmbeddableContent.where(user_id: current_user.id).reverse
                end
    @contents = Kaminari.paginate_array(@contents).page(params[:page]).per(2)
  end

  def new
    @content = EmbeddableContent.new
    @stylsheet = @content.content_stylesheets.build unless @content.content_stylesheets
    @content_publisher = @content.content_publishers.build unless @content.content_publishers
  end

  def create
    @content = EmbeddableContent.new(content_params)
    if @content.save
      flash[:success] = "Content Successfully Created"
      redirect_to contents_path
    else
      render :new
    end
  end

  def edit
    @stylsheet = @content.content_stylesheets.build unless @content.content_stylesheets.any?
    @content_publisher = @content.content_publishers.build unless @content.content_publishers.any?
  end

  def update
    byebug
    if @content.update(content_params)
      flash[:success] = "Content Successfully Updated"
      redirect_to contents_path
    else
      render :edit
    end
  end

  def show
    @stylesheets = @content.content_stylesheets
    @content_publishers = @content.content_publishers
    if current_user.publisher?
      publisher_stylsheets = @content.content_stylesheets.by_user(@current_user.id)
      remaining_stylsheets = publisher_stylsheets - @stylesheets
      @stylesheets = publisher_stylsheets + remaining_stylsheets
    end
    @content_publishers = Kaminari.paginate_array(@content_publishers).page(params[:page]).per(2)
    @stylesheets = Kaminari.paginate_array(@stylesheets).page(params[:page]).per(2)
  end

  def destroy
    if @content.destroy
      flash[:success] = "Content Successfully Deleted"
    end
    redirect_to contents_path
  end

  def add_stylesheet
    @content.content_stylesheets.build
    render :edit
  end

  def remove_stylesheet
    @content.content_stylesheets.find_by_id(params[:stylesheet_id]).destroy
    @content.content_stylesheets.build unless @content.content_stylesheets.any?
    render :edit
  end

  private

  def content_params
    params.require(:embeddable_content).permit(:user_id,
      content_stylesheets_attributes: [:id, :name,:body, :user_id, :_destroy],
      content_publishers_attributes: [:id, :header, :footer, :user_id]
      )
  end

  def get_content
    @content = EmbeddableContent.find_by_id(params[:id])
  end
end
