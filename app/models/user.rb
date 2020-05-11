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
  has_many :follows, dependent: :destroy
  has_many :participates, dependent: :destroy
  has_many :participated_events, through: :participates, source: :event

  # instance methods
  def follow?(user)
    follows.exists?(following: user)
  end

  def follow!(user)
    if follow?(user)
      follows.find_by(following: user).destroy
      return 'Follow'
    else
      follows.create(following: user)
      return 'Followed'
    end
  end
end
