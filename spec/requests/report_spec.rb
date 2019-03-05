require 'swagger_helper'
require 'assistances_helper'

describe 'Reports API' do
  include_context 'shared auth'
  
  # Enable generation of examples with request responses for each test
  generate_examples_with_responses
  
  let(:admin) { create(:employee, :admin) }
  let!(:employee) { create(:employee) }
  
  before :each do
    host! 'localhost:3000'
  end

  path '/reports/{employee_id}/journeys?start_date={start_date}&end_date={end_date}' do
    context 'when admin' do
      let(:headers) { admin.create_new_auth_token }
      let(:employee_id) { employee.id }

      context 'when requesting journey for one day' do
        let!(:start_date) { DateTime.now.beginning_of_day.to_date.iso8601 }
        let!(:end_date) { start_date }
        let(:assistance_day) { DateTime.now.beginning_of_day }
        let!(:anomaly) { create(:anomaly, day: assistance_day, employee: employee) }
        before { generate_assistances_for_one_day }

        get 'Get journey by employee' do
          tags 'Reports'
          consumes 'application/json'
          produces 'application/json'
          parameter name: :employee_id, in: :path, type: :string, required: true
          parameter name: :start_date, in: :path, type: :string, required: true
          parameter name: :end_date, in: :path, type: :string, required: true
          add_authentication_headers

          response '200', 'Returns journes by employee in the given date range' do
            schema '$ref' => schema_url('journeys_response')
            run_test! do
              json = JSON.parse(response.body)
              expect(json).to include_json(employee_journey_response(start_date))
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
            let(:employee_id) { create(:employee).id }
            run_test! do
              json = JSON.parse(response.body)
              expect(json).to include_json(not_authorized_error)
            end
          end

        end
      end
    end
  end
end