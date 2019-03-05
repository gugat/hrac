require 'swagger_helper'

describe 'Employees API' do

  include_context 'shared auth'

  # Enable generation of examples with request responses for each test
  generate_examples_with_responses

  let!(:employees) { create_list(:employee, 5) }
  let!(:employee) { employees.last }
  let!(:admin) { create(:employee, :admin) }
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
  let(:headers) { admin.create_new_auth_token }

  path '/employees/{employee_id}' do

    get 'Find an employee by id' do
      tags 'Employees'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :employee_id, in: :path, type: :string, required: true
      add_authentication_headers

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

      response '403', 'Not authorized to see an employee' do
        schema '$ref' => schema_url('errors')
        let(:headers) { employee.create_new_auth_token }
        let(:employee_id) { employees[2].id }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(not_authorized_error)
        end
      end

    end
  end

  path '/employees' do
    get 'List employees' do
      tags 'Employees'
      consumes 'application/json'
      produces 'application/json'
      add_authentication_headers

      response '200', 'Return multiple employees' do
        schema '$ref' => schema_url('employees_response')
        let(:employee_id) { employee.id }
        run_test! do
          json = JSON.parse(response.body)
          expect(json['data'].size).to eq(6)
        end
      end

      response '403', 'Not authorized to list employees' do
        schema '$ref' => schema_url('errors')
        let(:headers) { employee.create_new_auth_token }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(not_authorized_error)
        end
      end

    end

    post 'Add a new employee' do
      tags 'Employees'
      consumes 'application/json'
      produces 'application/json'
      add_authentication_headers
      parameter name: :employee, in: :body, required: true, schema: {
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

      response '403', 'Not authorized to create an employee' do
        schema '$ref' => schema_url('errors')
        let(:headers) { employee.create_new_auth_token }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(not_authorized_error)
        end
      end

    end
  end
end
