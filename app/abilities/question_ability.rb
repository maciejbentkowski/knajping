# frozen_string_literal: true

class QuestionAbility
    include CanCan::Ability

    def initialize(user)
      can :read, Question

      return unless user.present?

<<<<<<< HEAD
      if user.owner?
        can [ :new, :create ], Question
        can [ :edit, :update, :destroy ], Question, user_id: user.id
      end

      if user.reviewer?
=======
      if user.reviewer? || user.owner?
>>>>>>> notifications
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
