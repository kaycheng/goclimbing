class Event < ApplicationRecord
  include AASM
  
  # Validations
  validates :title, presence: true
  
  # Relationships
  belongs_to :user
  has_many :participates, dependent: :destroy
  has_many :participated_users, through: :participates, source: :user

  # AASM
  aasm(column: 'status', no_direct_assignment: true) do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

  def is_participated?(user)
    self.participated_users.include?(user)
  end

  scope :not_overdue, -> { where(['date > ?', Time.now])}
  scope :overdue, -> { where(['date < ?', Time.now])}
end
