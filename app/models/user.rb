class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # validation
  validates :username, presence: true
  validates_uniqueness_of :username

  # relationships
  has_one_attached :avatar
  has_many :events, dependent: :destroy
end
