class AssistancesController < ApplicationController

  before_action :set_employee, only: [:index, :create ]

  def index
    assistances = @employee.assistances
    render json: serialize(assistances), status: 200
  end

  def create
    @assistance = @employee.assistances.create!(assistance_params)
    render json: serialize(@assistance), status: 201
  end

  private

  def assistance_params
    params.permit(:kind, :happening_at)
  end

  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def serialize(assistance)
    AssistanceSerializer.new(assistance).serialized_json
  end

  

end
