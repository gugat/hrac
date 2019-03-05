require 'swagger_helper'



describe 'Assistances API' do

  include_context 'shared auth'

  # Enable generation of examples with request responses for each test
  generate_examples_with_responses

  let!(:employer) { create(:employee, :admin) }
  let!(:employee) { create(:employee) }
  let!(:assistances) { create_list(:assistance, 5, employee_id: employee.id) }
  let(:employee_id) { employee.id }

  # Valid attributes
  let(:assistance_valid_attributes) do
    {
      happening_at: Time.now,
      kind: 'in',
      employee_id: employee_id
    }
  end

  # Invalid attributes

  let(:assistance_invalid_attributes) do
    {
      happening_at: Time.now,
      employee_id: employee_id
    }
  end

  # Generate authentication headers
  let(:headers) { employer.create_new_auth_token }

  path "/employees/{employee_id}/assistances" do
    get 'List employee assistances' do
      tags 'Assistances'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :employee_id, in: :path, type: :string, require: true
      add_authentication_headers

      response '200', 'Return multiple employee assistances' do
        schema '$ref' => schema_url('assistances_response')
        run_test! do
          json = JSON.parse(response.body)
          expect(json['data'].size).to eq(5)
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

      response '403', 'Not authorized to list assistances' do
        schema '$ref' => schema_url('errors')
        let(:headers) { employee.create_new_auth_token }
        let(:other_employee) { create(:employee) }
        let(:employee_id) { other_employee.id }
        run_test! do 
          json = JSON.parse(response.body)
          expect(json).to include_json(not_authorized_error)
        end
      end
    end
  end

  path "/employees/{employee_id}/assistances" do

    post 'Add new assistance' do
      tags 'Assistances'
      consumes 'application/json'
      produces 'application/json'
      add_authentication_headers
      parameter name: :employee_id, in: :path, type: :string, require: true
      parameter name: :assistance, in: :body, require: true, schema: {
        '$ref' => schema_url('assistance_request')
      }

      response '201', 'Assistance created' do
        schema '$ref' => schema_url('assistance_response')
        let(:assistance) { assistance_valid_attributes }
        run_test! do
          expected_json = created_assistance_message(assistance_valid_attributes)
          json = JSON.parse(response.body)
          expect(json).to include_json(expected_json)
        end
      end

      response '422', 'Invalid request' do
        schema '$ref' => schema_url('errors')
        let(:assistance) { assistance_invalid_attributes }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(invalid_params_assistance_message)
        end
      end
    end
  end
end
