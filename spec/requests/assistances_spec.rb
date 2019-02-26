require 'rails_helper'

RSpec.describe 'Assistances API', type: :request do

  include ExpectedResponseHelper::Assistance

  # Initialize test data
  let!(:employee) { create(:employee) }
  let!(:assistances) { create_list(:assistance, 5, employee_id: employee.id) }
  let(:assistance_id) { assistances.first.id }
  let(:employee_id) { employee.id }

  # Test suite for GET /assistances
  describe 'GET /employees/:employee_id/assistances' do
    before { get "/employees/#{employee_id}/assistances" }

    it 'return assistances' do
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

  end

  # Test suite for POST /employees/:employee_id/assistances
  describe 'POST /employees/:employee_id/assistances' do
    let(:valid_attributes) { { happening_at: DateTime.now,
                               kind: 'in',
                               employee_id: employee_id } }

    let(:invalid_attributes) { { happening_at: DateTime.now } }

    context 'when the assistance parameterers are valid' do
      before { post "/employees/#{employee_id}/assistances", 
               params: valid_attributes }

      it 'creates an assistance' do
        json = JSON.parse(response.body)
        expected_json = created_assistance_message(valid_attributes, employee_id)
        expect(response).to have_http_status(201)
        expect(json).to include_json(expected_json)
        expect(json).to match_json_schema('assistance')
      end
    end

    context 'when the assistance parameters are invalid' do

      before { post "/employees/#{employee_id}/assistances", 
               params: invalid_attributes }

      it 'returns a validation failure message' do
        json = JSON.parse(response.body)
        expect(response).to have_http_status(422)
        expect(json).to include_json(invalid_params_assistance_message)
        expect(json).to match_json_schema('errors')
      end
    end

  end

end