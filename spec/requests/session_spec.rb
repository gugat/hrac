require 'swagger_helper'

describe 'Authentication API' do

  include_context 'shared auth'

  # Enable generation of examples with request responses for each test
  generate_examples_with_responses

  let!(:employee) { create(:employee) }

  # Valid attributes
  let(:valid_login_parameters) do
    {
      email: employee.email,
      password: employee.password
    }
  end

  # Invalid attributes
  let(:invalid_login_parameters) do
    {
      email: employee.email,
      password: employee.password + 's'
    }
  end

  path '/auth/sign_in' do
    post 'Login employee' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :employee_login, in: :body, schema: {
        '$ref' => schema_url('employee_login')
      }

      response '200', 'Returns employee authenticated' do
        schema '$ref' => schema_url('employee_response')
        let(:employee_login) { valid_login_parameters }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(found_employee_message(employee))
        end
      end

      response '401', 'Returns bad credentials message' do
        schema '$ref' => schema_url('errors')
        let(:employee_login) { invalid_login_parameters }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(login_error)
        end
      end
    end
  end

  path '/auth/sign_out' do
    delete 'Logout employee' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      add_authentication_headers

      response '200', 'Logouts user' do
        schema '$ref' => schema_url('meta')
        let(:headers) { employee.create_new_auth_token }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(logout_success)
        end
      end

      response '404', 'Returns bad credentials message' do
        schema '$ref' => schema_url('errors')
        let(:wrong_header) { { "uid": 'Wring' }.stringify_keys }
        let(:headers) { employee.create_new_auth_token.merge!(wrong_header) }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(logout_error)
        end
      end
    end
  end

end