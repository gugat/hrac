module ExpectedResponseHelper

  module Assistance
    def created_assistance_message(valid_attributes, employee_id)
      {
        data: {
          type: 'assistance',
          attributes: {
            kind: valid_attributes[:kind],
            happening_at: valid_attributes[:happening_at].getlocal.iso8601
          },
          relationships: {
            employee: {
              data: {
                id: employee_id.to_s,
                type: 'employee'
              }
            }
          }
        }
      }
    end


    def invalid_params_assistance_message
      {
        errors: [
          {
            error: {
              title: 'Invalid record parameters',
              detail: "Validation failed: Kind can't be blank",
              code: '422'
            }
          }
        ]
      }
    end

  end
end