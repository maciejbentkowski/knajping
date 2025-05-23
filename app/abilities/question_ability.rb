# frozen_string_literal: true

class QuestionAbility
    include CanCan::Ability

    def initialize(user)
      can :read, Question

      return unless user.present?


      if user.reviewer? || user.owner?
        can [ :new, :create ], Question
        can [ :edit, :update, :destroy ], Question do |question|
          question.user_id == user.id
        end
      end

      if user.admin? || user.moderator?
        can :manage, Question
      end
    end
end
