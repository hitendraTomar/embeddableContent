require 'redis_backend'
class ContentsController < ApplicationController
  load_and_authorize_resource class: EmbeddableContent

  before_action :authenticate_user!, except: :show
  before_action :update_impression, only: :show

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

  def edit
    @content.content_publishers.build unless @content.content_publishers.find_by(user_id: current_user.id)
  end

  def update
    if @content.update(content_params)
      flash[:success] = "Content Successfully Updated"
      redirect_to contents_path
    else
      render :edit
    end
  end

  def show
    authenticate_user! unless @current_publisher
    if params[:path] && @current_publisher
      @content = @current_publisher.contents.find_by('lower(title) = ?', params[:path].gsub('-', ' '))
      (redirect_to my_publications_content_publishers_path, error: 'Invalid URL') and return unless @content
    end
    @stylesheets = @content.content_stylesheets.by_user((@current_publisher || current_user).id).page(params[:page]).per(2)
    @styles = @stylesheets.map(&:body).join
    @content_publishers = @content.content_publishers.page(params[:page]).per(2)
  end

  def destroy
    if @content.destroy
      flash[:success] = "Content Successfully Deleted"
    end
    redirect_to contents_path
  end

  def my_impressions
    redis = RedisBackend.new
    @content_publishers = []
    @contents.each do |content|
      content.content_publishers.each do |content_publisher|
        @content_publishers << content_publisher
      end
    end
  end

  private

  def content_params
    params.require(:embeddable_content).permit(:user_id, :header, :body, :title, :footer,
      content_stylesheets_attributes: [:id, :name, :body, :user_id, :_destroy],
      content_publishers_attributes: [:id, :header, :footer, :user_id]
      )
  end

  def update_impression
    redis = RedisBackend.new
    content_publisher = @content.content_publishers.find_by_user_id(current_user&.id)
    impression_count = "content_#{@content&.id}_publisher_#{content_publisher&.id}_impression_count"
    redis[impression_count] = redis[impression_count].to_i + 1
  end
end
