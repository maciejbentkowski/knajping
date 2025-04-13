# frozen_string_literal: true

class AnswerAbility
    include CanCan::Ability

    def initialize(user)
      can :read, Answer

      return unless user.present?

<<<<<<< HEAD
      if user.owner?
        can [ :new, :create ], Answer
        can [ :edit, :update, :destroy ], Answer, user_id: user.id
      end

      if user.reviewer?
=======
      if user.reviewer? || user.owner?
>>>>>>> notifications
        can [ :new, :create ], Answer
        can [ :edit, :update, :destroy ], Answer do |answer|
          answer.user_id == user.id
        end
      end

      if user.admin? || user.moderator?
        can :manage, Answer
      end
    end
end
