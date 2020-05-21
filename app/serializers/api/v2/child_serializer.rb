module Api::V2
class ChildSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :points_earned, :active

  attribute :completed_chores do |object|
    object.chores.done.map do |chore|
      ChoreSerializer.new(chore)
    end
  end

  attribute :pending_chores do |object|
    object.chores.pending.map do |chore|
      ChoreSerializer.new(chore)
    end
  end

end
end