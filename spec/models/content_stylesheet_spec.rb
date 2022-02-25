require 'rails_helper'

RSpec.describe ContentStylesheet, type: :model do

  describe 'associations' do
    it { should belong_to(:embeddable_content) }
    it { should belong_to(:user) }
  end

end
