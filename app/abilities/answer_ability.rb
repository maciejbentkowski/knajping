# frozen_string_literal: true

class AnswerAbility
    include CanCan::Ability

    def initialize(user)
      can :read, Answer

      return unless user.present?

      if user.reviewer?
        can [ :new, :create ], Answer
        can [ :edit, :update ], Answer do |question|
          question.user_id == user.id
        end
      end

      if user.admin? || user.moderator?
        can :manage, Answer
      end
    end
end
