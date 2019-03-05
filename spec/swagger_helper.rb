require 'rails_helper'

RSpec.configure do |config|
  
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.to_s + '/swagger'

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:to_swagger' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API V1',
        version: 'v1'
      },

      "securityDefinitions": {
        "client": {
          "type": "apiKey",
          "name": "client",
          "in": "header"
        },
        "access-token": {
          "type": "apiKey",
          "name": "access-token",
          "in": "header"
        },
        "uid": {
          "type": "apiKey",
          "name": "uid",
          "in": "header"
        }
      },
      # "security": [
      #   {
      #     "client": [],
      #     "access-token": [],
      #     "uid": []
      #   }
      # ],
      definitions: {
      },

      paths: {},

    }
  }

  #
  # Stub request calls to schemas url returning the file content
  #
  config.before(:each) do
    config = Rails.application.config_for(:api)
    schemas_path = config['schemas_path']
    stub_request(:get, /schemas/).
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(
        lambda { |request|
          schema_name = URI.parse(request.uri).path.split('/').last
          schema_file = "#{schemas_path}/#{schema_name}.json"
          { 
            status: 200, 
            body: File.read(schema_file), 
            headers: {}
          }
        }
      )
  end

end

def generate_examples_with_responses
  after do |example|
    example.metadata[:response][:examples] = { 
      'application/json' => JSON.parse(response.body, symbolize_names: true) }
  end
end