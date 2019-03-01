# :nodoc:
class EmployeesController < ApplicationController

  before_action :authenticate_employee!
  before_action :set_employee, only: [:show]

  def index
    authorize Employee
    employees = Employee.all
    render json: serialize(employees), status: 200
  end

  def show
    authorize @employee
    render json: serialize(@employee), status: 200
  end

  def create
    authorize Employee
    @employee = Employee.create!(employee_params)
    render json: serialize(@employee), status: 201
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.permit(:first_name, :last_name, :email, :password)
  end

  def serialize(employee)
    EmployeeSerializer.new(employee).serialized_json
  end
end
