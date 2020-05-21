module Api::V2
class ChoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :child, :task, :due_on, :completed

  attribute :completed do |object|
    object.status
  end

  attribute :task do |object|
    ChoreTaskSerializer.new(object.task)
  end

  attribute :child do |object|
    ChoreChildSerializer.new(object.child)
  end
end
end