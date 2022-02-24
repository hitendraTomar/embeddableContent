class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_uniqueness_of :name, :case_sensitive => false


  def publisher?
    self.class.name == "Publisher"
  end

  def creator?
    self.class.name == "Creator"
  end
end
