require 'cancancan'

module MongoidAbility
  class Ability
    include CanCan::Ability
    def initialize owner
      can do |action, subject_type, subject, options|
        subject_class = subject_type.to_s.constantize
        outcome = nil
        subject_class.self_and_ancestors_with_default_locks.each do |cls|
          outcome = InheritedLocksResolver.new(owner, action, cls, subject, options).outcome
          break if outcome != nil
        end
        outcome
      end
    end
  end
end




#     private # =============================================================
#

#
#   end
# end
