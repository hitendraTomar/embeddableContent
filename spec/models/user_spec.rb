require 'rails_helper'

describe User, :type => :model do

  context "valid Factory" do
    it "has a valid factory" do
      expect(build(:user)).to be_valid
    end

    it { should validate_uniqueness_of(:name).case_insensitive }

  end
end