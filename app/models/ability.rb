# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_a? Publisher
      can [:index, :show, :edit, :update], EmbeddableContent
    else
      can :manage, EmbeddableContent, user_id: user.id
    end
  end
end
