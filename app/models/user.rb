class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  
  # validation
  validates :username, presence: true
  validates_uniqueness_of :username

  # relationships
  has_one_attached :avatar
  has_many :events, dependent: :destroy
  
  has_many :follows, dependent: :destroy
  has_many :followings, through: :follows

  has_many :inverse_follows, foreign_key: "following_id", class_name: "Follow"
  has_many :followers, through: :inverse_follows, source: :user
  
  has_many :participates, dependent: :destroy
  has_many :participated_events, through: :participates, source: :event

  has_many :comments, dependent: :destroy

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

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.credentials.token, :uid => access_token.uid ).first    
    if user
      return user
    else
      existing_user = User.where(:email => data["email"]).first
      if  existing_user
        existing_user.uid = access_token.uid
        existing_user.provider = access_token.credentials.token
        existing_user.save!
        return existing_user
      else
    # Uncomment the section below if you want users to be created if they don't exist
        user = User.create(
            username: data["name"],
            email: data["email"],
            password: Devise.friendly_token[0,20],
            provider: access_token.credentials.token,
            uid: access_token.uid
          )
      end
    end
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
