require 'rails_helper'

RSpec.describe ContentPublishersController, type: :controller do

  let!(:publisher) { create(:publisher) }
  let!(:creator) { create(:creator) }

  before do
    @request.host = "#{publisher.name}.example.com"
  end

  describe "GET /my_publications" do
    context 'fetch published contents' do
      it 'fetch publishers content if current publisher present' do
        content = create(:embeddable_content, creator: creator)
        content_publisher = create(:content_publisher, publisher: publisher, content: content)
        get :my_publications
        expect(@controller.instance_variable_get(:@contents)).to include(content)
      end
      it 'fetch creators content unless publisher present and creator logged in' do
        @request.host = "example.com"
        sign_in creator
        content = create(:embeddable_content, creator: creator)
        content_publisher = create(:content_publisher, publisher: creator, content: content)
        get :my_publications
        expect(@controller.instance_variable_get(:@contents)).to include(content)
      end
    end
  end

  describe "GET /add_publisher" do
    context 'add content publisher' do
      it 'add new content publisher if not present' do
        content = create(:embeddable_content, creator: publisher)
        sign_in publisher
        expect do
          get :add_publisher, params: { content_id: content.id }
        end.to change {ContentPublisher.count}.by(1)

      end
      it 'find existing content publisher' do
        content = create(:embeddable_content, creator: publisher)
        content_publisher = create(:content_publisher, publisher: publisher, content: content)
        sign_in publisher
        expect do
          get :add_publisher, params: { content_id: content.id }
        end.to change {ContentPublisher.count}.by(0)
      end
    end
  end
end