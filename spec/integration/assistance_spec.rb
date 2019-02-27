require 'swagger_helper'

include ExpectedResponseHelper::Assistance
include ExpectedResponseHelper::Employee
include Rails.application.routes.url_helpers

describe 'Assistances API' do

  let!(:employee) { create(:employee) }
  let!(:assistances) { create_list(:assistance, 5, employee_id: employee.id) }
  let(:assistance_id) { assistances.first.id }
  let(:employee_id) { employee.id }
  
  path "/employees/{employee_id}/assistances" do

    get 'List employee assistances' do
      tags 'Assistances'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :employee_id, in: :path, type: :string, require: :true

      response '200', 'Return multiple employee assistances' do
        schema '$ref' => schema_url('assistances_response')
        # let(:employee_id) { employee.id }
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
    end

  end


  path "/employees/{employee_id}/assistances" do

    post 'Add new assistance' do
      tags 'Assistances'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :employee_id, in: :path, type: :string, require: :true
      parameter name: :assistance, in: :body, require: :true, schema: {
        '$ref' => schema_url('assistance_request')
      }

      response '201', 'Assistance created' do
        schema '$ref' => schema_url('assistance_response')
        let(:assistance) { { happening_at: DateTime.now,
                             kind: 'in',
                             employee_id: employee_id } }
        run_test! do
          expected_json = created_assistance_message(assistance)
          json = JSON.parse(response.body)
          expect(json).to include_json(expected_json)
        end
      end
 
      response '422', 'Invalid request' do
        schema '$ref' => schema_url('errors')
        let(:assistance) { { happening_at: DateTime.now,
                             employee_id: employee_id } }
        run_test! do
          json = JSON.parse(response.body)
          expect(json).to include_json(invalid_params_assistance_message)
        end
      end
    end

  end

end