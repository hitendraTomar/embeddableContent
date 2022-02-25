class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_a? Publisher
      can [:index, :show, :edit, :update, :link], EmbeddableContent, id: user.contents.ids
    else
      can :manage, EmbeddableContent, user: user
    end
  end
end
