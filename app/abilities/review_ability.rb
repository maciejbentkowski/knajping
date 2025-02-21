# frozen_string_literal: true

class ReviewAbility
    include CanCan::Ability

    def initialize(user)
      can :read, Review

      return unless user.present?

      if user.reviewer?
        can [ :new, :create ], Review
        can [ :edit, :update ], Review do |review|
          review.user_id == user.id
        end
      end

      if user.admin? || user.moderator?
        can :manage, Review
      end
    end
end
