class AssistanceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :kind
  attribute :happening_at do |object|
    object.happening_at.getlocal.iso8601
  end
  belongs_to :employee
end