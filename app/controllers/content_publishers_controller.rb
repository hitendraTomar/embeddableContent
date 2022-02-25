class ContentPublishersController < ApplicationController

  def add_publisher
    ContentPublisher.create!(user_id: current_user.id, embeddable_content_id: params[:content_id])
    redirect_to contents_path
  end

  def my_publications
  end
end
