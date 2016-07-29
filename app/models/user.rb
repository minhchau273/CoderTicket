class User < ActiveRecord::Base
  has_secure_password

  validates :name, :email, presence: true
  validates :password, length: { minimum: PASSWORD_MIN_LENGTH }
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, on: :create
end
