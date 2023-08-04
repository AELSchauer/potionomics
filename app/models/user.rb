class User < ApplicationRecord
  has_many :cupboards
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  after_create do
    Cupboard.create(user: self, name: "My First Game")
  end
end
