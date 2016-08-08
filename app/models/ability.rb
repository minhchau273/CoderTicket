class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.id
      can :read, Order, user: user
      can :create, Order
    end
  end
end
