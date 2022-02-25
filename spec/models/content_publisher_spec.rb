require 'rails_helper'

RSpec.describe ContentPublisher, type: :model do

  describe 'associations' do
    it { should belong_to(:publisher).class_name('User') }
    it { should belong_to(:content).class_name('EmbeddableContent') }
  end

end
