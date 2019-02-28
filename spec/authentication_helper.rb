#
# Add authentication headers to the request.
#
# Usage of `parameter` follows the Swagger specification
# https://swagger.io/specification/#parameterObject
#
#

def add_authentication_headers
  ['access-token', 'token_type', 'client', 'uid', 'expiry'].each do |header|
    parameter name: :"#{header}", in: :header, type: :string, required: true
  end

  # After added, you should assign a value for each paramete.
  # See shared context named as "shared auth parameters" declared below.
end


#
# Share assignation of authentication headers.
#
# To know how to use shared context see
# https://relishapp.com/rspec/rspec-core/v/3-5/docs/example-groups/shared-context
#
#

RSpec.configure do |rspec|
  # This config option will be enabled by default on RSpec 4,
  # but for reasons of backwards compatibility, you have to
  # set it on RSpec 3.
  #
  # It causes the host group and examples to inherit metadata
  # from the shared context.
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "shared auth", :shared_context => :metadata do
  before { @some_var = :some_value }

  # Assign authentication headers
  let(:'access-token') { headers['access-token'] }
  let(:token_type) { headers['token-type'] }
  let(:client) { headers['client'] }
  let(:uid) { headers['uid'] }
  let(:expiry) { headers['expiry'] }

end

RSpec.configure do |rspec|
  rspec.include_context "shared auth", :include_shared => true
end