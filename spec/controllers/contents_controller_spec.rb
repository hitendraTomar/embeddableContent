require 'rails_helper'

RSpec.describe ContentsController, type: :controller do

  let!(:publisher) { create(:publisher) }
  let!(:creator1) { create(:creator) }
  let!(:creator2) { create(:creator) }

  before do
    @request.host = "#{publisher.name}.example.com"
  end

  describe "GET /index" do
    it 'should unauthorized unless current user' do
      sign_out publisher
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "assign publisher as @current_publisher for request subdomain" do
      sign_in publisher
      get :index
      expect(@controller.instance_variable_get(:@current_publisher)).to eq(publisher)
    end

    it 'fetch 2 if user is publisher in reverse order' do
      contents = create_list(:embeddable_content, 2, creator: creator1)
      sign_in publisher
      get :index
      expect(@controller.instance_variable_get(:@contents)).to eq(contents)
    end

    it "fetch only logged in creator's content" do
      contents1 = create_list(:embeddable_content, 2, creator: creator1)
      sign_in creator1
      get :index
      expect(@controller.instance_variable_get(:@contents)).to eq(contents1)
    end
  end

  describe 'GET /new' do
    it 'initialize new content instance if user is creator' do
      sign_in creator1
      get :new
      expect(@controller.instance_variable_get(:@content)).to be_a_new(EmbeddableContent)
    end

    # it 'unauthorized if user is publisher' do
    #   sign_in publisher
    #   get :new

    # end
  end

  describe 'POST /create' do
    it 'create new content with stylesheet when user is creator and content is valid' do
      sign_in creator1
      expect do
        post :create, params: {
          embeddable_content: {
            header: 'header',
            body: 'Body',
            title: 'Title',
            footer: 'Footer'
          }
        }
      end.to change { EmbeddableContent.count }.by(1)
    end

    it 'do not create new content with invalid' do
      sign_in creator1
      post :create, params: {
        embeddable_content: {
          header: 'Header',
          body: 'Body',
          title: nil,
          footer: 'Footer'
        }
      }
      expect(@controller.instance_variable_get(:@content)).to be_invalid
    end
  end

  describe 'PATCH /update' do
    it 'update content record' do
      sign_in creator1
      content = create(:embeddable_content, creator: creator1)
      patch :update, params: {
        id: content.id,
        embeddable_content: {
          header: 'Updated header'
        }
      }
      expect(@controller.instance_variable_get(:@content).header).to eq('Updated header')
      expect(flash[:success]).to eq('Content Successfully Updated')
    end
  end

  describe 'destroy' do
    it 'destroy content id user is creator' do
      sign_in creator1
      content = create(:embeddable_content, creator: creator1)
      expect do
        delete :destroy, params: { id: content.id }
      end.to change {EmbeddableContent.count}.by(-1)
      expect(flash[:success]).to eq('Content Successfully Deleted')
    end
  end

  describe 'GET /show' do
    it 'can see particular content its stylesheet and content publishers when current publisher present' do
      content = create(:embeddable_content, creator: publisher)
      content_publisher = create(:content_publisher, content: content, publisher: publisher)
      content_stylesheet = create(:content_stylesheet, embeddable_content: content, user: publisher)
      content_publisher = create(:content_publisher, content: content)
      get :show, params: { path: "#{content.title.gsub(' ', '-')}"}
      expect(@controller.instance_variable_get(:@content)).to eq(content)
      expect(@controller.instance_variable_get(:@stylesheets)).to include(content_stylesheet)
      expect(@controller.instance_variable_get(:@content_publishers)).to include(content_publisher)
    end

    it 'can see particular content its stylesheet and content publishers when current user is present' do
      content = create(:embeddable_content, creator: creator1)
      content_stylesheet = create(:content_stylesheet, embeddable_content: content, user: publisher)
      content_publisher = create(:content_publisher, content: content)
      get :show, params: {id: content.id}
      expect(@controller.instance_variable_get(:@content)).to eq(content)
      expect(@controller.instance_variable_get(:@styles)).to eq(content_stylesheet.body)
      expect(@controller.instance_variable_get(:@content_publishers)).to include(content_publisher)
    end
  end
end