def set_authentication_parameters
  ['access-token', 'token_type', 'client', 'uid', 'expiry'].each do |header|
    parameter name: :"#{header}", in: :header, type: :string
  end
  # After set, they should have a value, see usage of `let` for each one below.
end