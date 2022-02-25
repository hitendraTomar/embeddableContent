# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_a? Publisher
      can [:index, :show, :edit, :update], EmbeddableContent
      can :add_publisher, ContentPublisher, (user.is_a? Publisher)
    elsif user.is_a? Creator
      can :manage, EmbeddableContent, user_id: user.id
    end
    can :show, EmbeddableContent
    can :my_publications, ContentPublisher
  end
end
