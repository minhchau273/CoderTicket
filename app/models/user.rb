class User < ActiveRecord::Base
  has_secure_password

  has_many :orders, -> { order(created_at: :desc) }

  validates :name, :email, presence: true
  validates :password, length: { minimum: PASSWORD_MIN_LENGTH }
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, on: :create

  def total_amount
    orders.map(&:total).sum
  end
end
