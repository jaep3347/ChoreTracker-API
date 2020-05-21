module Api::V1
class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :points, :active
end
end