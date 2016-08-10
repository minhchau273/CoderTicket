class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.id
      can :read, Order, user: user
      can :create, Order
      can :view_events_of, User, id: user.id
    end
  end
end
