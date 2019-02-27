# :nodoc:
class EmployeesController < ApplicationController

  before_action :set_employee, only: [:show]

  def index
    employees = Employee.all
    render json: serialize(employees), status: 200
  end

  def show
    render json: serialize(@employee), status: 200
  end

  def create
    @employee = Employee.create!(employee_params)
    render json: serialize(@employee), status: 201
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.permit(:first_name, :last_name)
  end

  def serialize(employee)
    EmployeeSerializer.new(employee).serialized_json
  end
end
