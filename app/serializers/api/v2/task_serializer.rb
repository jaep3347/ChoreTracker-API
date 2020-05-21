module Api::V2
class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :points, :active
end
end