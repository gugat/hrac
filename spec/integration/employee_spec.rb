require 'swagger_helper'

include ExpectedResponseHelper::Employee
include Rails.application.routes.url_helpers

def set_authentication_parameters
  ['access-token', 'token_type', 'client', 'uid', 'expiry'].each do |header|
    parameter name: :"#{header}", in: :header, type: :string
  end
  # After set, they should have a value, see usage of `let` for each one below.
end

describe 'Employees API' do

  let!(:employees) { create_list(:employee, 5) }
  let!(:employee) { employees.last }
  let!(:employer) { employees.first }
  let(:employee_id) { employee.id }

  # Valid attributes
  let(:employee_valid_attributes) do
    {
      first_name: 'Gus',
      last_name: 'Sal',
      email: 'gussal@example.com',
      password: '123123123'
    }
  end

  # Invalid attributes
  let(:employee_invalid_attributes) do
    # Missing last name
    {
      first_name: 'Gus',
      email: 'gussal@example.com',
      password: '123123123'
    }
  end

  # Generate authentication headers
  let(:headers) { employer.create_new_auth_token }

  # Assign authentication headers to variables
  let(:'access-token') { headers['access-token'] }
  let(:token_type) { headers['token-type'] }
  let(:client) { headers['client'] }
  let(:uid) { headers['uid'] }
  let(:expiry) { headers['expiry'] }

  path '/employees/{employee_id}' do

    get 'Find an employee by id' do
      tags 'Employees'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :employee_id, in: :path, type: :string, require: true
      set_authentication_parameters

      response '200', 'Returns a single employee' do
        schema '$ref' => schema_url('employee_response')
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(found_employee_message(employee))
        end
      end

      response '404', 'Employee not found' do
        schema '$ref' => schema_url('errors')
        let(:employee_id) { 2000 }
        run_test! do
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
      set_authentication_parameters

      response '200', 'Return multiple employees' do
        schema '$ref' => schema_url('employees_response')
        let(:employee_id) { employee.id }
        run_test! do
          json = JSON.parse(response.body)
          expect(json['data'].size).to eq(5)
        end
      end
    end

    post 'Add a new employee' do
      tags 'Employees'
      consumes 'application/json'
      produces 'application/json'
      set_authentication_parameters
      parameter name: :employee, in: :body, require: true, schema: {
        '$ref' => schema_url('employee_request')
      }

      response '201', 'Employee created' do
        schema '$ref' => schema_url('employee_response')
        let(:employee) { employee_valid_attributes }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(created_employee_message(employee))
        end
      end

      response '422', 'Invalid request' do
        schema '$ref' => schema_url('errors')
        let(:employee) { employee_invalid_attributes }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(invalid_params_employee_message)
        end
      end
    end
  end
end
