require 'redis_backend'
class ContentPublishersController < ApplicationController
  load_and_authorize_resource

  def add_publisher
    ContentPublisher.find_or_create_by!(user_id: current_user.id, embeddable_content_id: params[:content_id])
    redirect_to my_publications_content_publishers_path
  end

  def my_publications
    @contents = EmbeddableContent.joins(:content_publishers).where(content_publishers: { user_id: (@current_publisher || current_user).id }).page(params[:page]).per(2)
  end

  def my_impressions
    redis = RedisBackend.new
  end
end
