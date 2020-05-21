module Api::V1
class ChoreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :child_id, :task, :due_on, :completed

  attribute :completed do |object|
    object.status
  end

  attribute :task do |object|
    ChoreTaskSerializer.new(object.task)
  end
end
end