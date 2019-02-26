require 'rails_helper'

RSpec.describe 'Employees API', type: :request do

  include ExpectedResponseHelper::Employee

  # Initialize test data
  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }
  let(:employee_id) { employee.id }

  # Test suite for GET /employees
  describe 'GET /employees' do
    before { get '/employees' }

    it 'returns employees' do
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

  end

  # Test suite for GET /employees/:id
  describe 'GET /employees/:id' do
    before { get "/employees/#{employee_id}" }

    context 'when the employee exists' do

      it 'returns the employee' do
        json = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(json).to include_json(found_employee_message(employee))
        expect(json).to match_json_schema('employee')
      end

    end

    context 'when the employee does not exist' do
      let(:employee_id) { 2000 }

      it 'returns a not found employee message' do
        json = JSON.parse(response.body)
        expect(response).to have_http_status(404)
        expect(json).to include_json(not_found_employee_message(employee_id))
        expect(json).to match_json_schema('errors')
      end

    end

  end

  # Test suite for POST /employees
  describe 'POST /employees' do
    let(:valid_attributes) { { first_name: 'Gustavo', last_name: 'Salazar' } }
    let(:invalid_attributes) { { first_name: 'Gustavo' } }

    context 'when the employee parameters are valid' do
      before { post '/employees', params: valid_attributes }

      it 'creates an employee' do
        json = JSON.parse(response.body)
        expect(response).to have_http_status(201)
        expect(json).to include_json(created_employee_message(valid_attributes))
        expect(json).to match_json_schema('employee')
      end
    end

    context 'when employee parameters are invalid' do

      before { post '/employees', params: invalid_attributes }

      it 'returns a validation failure message' do
        json = JSON.parse(response.body)
        expect(json).to include_json(invalid_params_employee_message)
        expect(json).to match_json_schema('errors')
      end
    end

  end
end