class EmployeePolicy < ApplicationPolicy

  attr_reader :current_employee, :other_employee

  def initialize(current_employee, other_employee)
    @current_employee = current_employee
    @other_employee = other_employee
  end

  def index?
    current_employee.admin?
  end

  def show?
    current_employee.admin? || (current_employee.id == other_employee.id)
  end

  def create?
    current_employee.admin?
  end

  def list_assistances?
    current_employee.admin? || (current_employee.id == other_employee.id)
  end

  def show_journeys_report?
    current_employee.admin? || (current_employee.id == other_employee.id)
  end
end