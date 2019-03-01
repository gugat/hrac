class AssistancePolicy < ApplicationPolicy

  attr_reader :current_employee, :assistance

  def initialize(current_employee, assistance)
    @current_employee = current_employee
    @assistance = assistance
  end

  def create?
    current_employee.admin?
  end
end