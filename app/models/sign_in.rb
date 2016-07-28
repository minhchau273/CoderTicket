class SignIn
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :email, :password

  validates :email, :password, presence: true
  validate :check_user_and_password

  delegate :id, to: :user, prefix: true

  def initialize(options = {})
    self.email = options[:email]
    self.password = options[:password]
  end

  def user
    User.find_by(email: email)
  end

  private

  def check_user_and_password
    if user
      errors.add(:password, "does not match") unless user.authenticate(password)
    elsif email.present?
      errors.add(:email, "is not found")
    end
  end
end
