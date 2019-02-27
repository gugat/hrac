require 'swagger_helper'

include ExpectedResponseHelper::Employee
include Rails.application.routes.url_helpers

describe 'Employees API' do

  let!(:employees) { create_list(:employee, 5) }
  let(:employee) { employees.first }

  path '/employees/{employee_id}' do

    get 'Find an employee by id' do
      tags 'Employees'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :employee_id, in: :path, type: :string, require: :true

      response '200', 'Returns a single employee' do
        schema '$ref' => schema_url('employee_response')
        let(:employee_id) { employee.id }
        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json).to include_json(found_employee_message(employee))
        end
      end

      response '404', 'Employee not found' do
        schema '$ref' => schema_url('errors')
        let(:employee_id) { 2000 }
        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json).to include_json(not_found_employee_message(employee_id))
        end
      end

    end
  end

  path '/employees' do

    get 'List employees' do
      tags 'Employees'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Return multiple employees' do
        schema '$ref' => schema_url('employees_response')
        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json['data']).not_to be_empty
          expect(json['data'].size).to eq(5)
        end
      end
    end


    post 'Add a new employee' do
      tags 'Employees'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :employee, in: :body, require: :true, schema: {
        '$ref' => schema_url('employee_request')
      }

      response '201', 'Employee created' do
        let(:employee) { { first_name: 'Gus', last_name: 'Sal' } }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(created_employee_message(employee))
        end
      end

      response '422', 'Invalid request' do
        schema '$ref' => schema_url('errors')
        let(:employee) { { first_name: 'Gus' } }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(invalid_params_employee_message)
          expect(json).to match_json_schema('errors')
        end
      end
    end
  end

end