class User < ActiveRecord::Base
  has_secure_password

  validates :name, :email, presence: true
  validates :password, length: { minimum: 6 }
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, :on => :create
end
