class User < ApplicationRecord
  enum :role, [ :reviewer, :owner, :moderator, :admin ]
  after_initialize :set_default_role, if: :new_record?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :username, presence: true

  has_many :venues, inverse_of: :user, dependent: :nullify
  has_many :reviews, inverse_of: :user, dependent: :nullify
  has_many :questions, inverse_of: :user, dependent: :nullify
  has_many :answers, inverse_of: :user, dependent: :nullify

  has_one_attached :avatar

  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification", counter_cache: :notifications_count

  
  def admin_or_moderator?
    %w[admin moderator].include?(role)
  end

  def notifications_quantity
    self.notifications.where(read_at: nil).count
  end
  private


  def set_default_role
    self.role ||= :reviewer
  end
end
