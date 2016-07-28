class SignIn
  attr_accessor :email, :password

  include ActiveModel::Validations
  include ActiveModel::Conversion

  validates :email, :password, presence: true
  validate :check_user_and_password

  delegate :id, to: :user, prefix: true

  def initialize(options = {})
    if options
      self.email    = options[:email]
      self.password = options[:password]
    end
  end

  def user
    User.find_by email: email
  end

  def check_user_and_password
    if user
      errors.add(:password, "does not match.") unless user.authenticate(password)
    elsif email.present?
      errors.add(:email, "is not found.")
    end
  end
end
