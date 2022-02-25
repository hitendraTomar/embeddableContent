require 'rails_helper'

RSpec.describe EmbeddableContent, type: :model do

  describe 'associations' do
    it { should have_many(:content_publishers) }
    it { should have_many(:publishers) }
    it { should have_many(:content_stylesheets) }
    it { should belong_to(:creator).class_name('User') }
  end

end
