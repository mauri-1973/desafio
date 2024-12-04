class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    case user.role
    when 'admin'
      can :manage, :all  # Los administradores pueden hacer todo
    when 'moderator'
      can :read, :all          # Los moderadores pueden leer todo
      can :update, Post
      can :create, Comment
    when 'user'
      can :read, :all          # Los moderadores pueden leer todo
      can :like, Post
      can :create, Comment      # Los moderadores pueden actualizar Post
    else
      can :read, Post          # Los usuarios regulares pueden leer Post
    end
  end
end