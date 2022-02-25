class ContentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource class: EmbeddableContent

  def index
    @contents = @contents.page(params[:page]).per(10)
  end

  def new;  end

  def create
    if @content.save
      flash[:success] = "Content Successfully Created"
      redirect_to contents_path
    else
      render :new
    end
  end

  def edit; end

  def update
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
    params.require(:embeddable_content).permit(:user_id, :header, :body, :title, :footer,
      content_stylesheets_attributes: [:id, :name, :body, :user_id, :_destroy],
      content_publishers_attributes: [:id, :header, :footer, :user_id]
      )
  end
end
