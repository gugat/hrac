# :nodoc:
module ExpectedResponseHelper
  # :nodoc:
  module Employee
    def found_employee_message(employee)
      {
        data: {
          id: employee.id.to_s,
          type: 'employee',
          attributes: {
            first_name: employee.first_name,
            last_name: employee.last_name,
            email: employee.email
          }
        }
      }
    end

    def created_employee_message(valid_attributes)
      {
        data: {
          type: 'employee',
          attributes: {
            first_name: valid_attributes[:first_name],
            last_name: valid_attributes[:last_name],
            email: valid_attributes[:email]
          }
        }
      }
    end

    def not_found_employee_message(employee_id)
      {
        errors: [
          {
            title: 'Record not found',
            detail: "Couldn't find Employee with 'id'=#{employee_id}",
            code: '404'
          }
        ]
      }
    end

    def invalid_params_employee_message
      {
        errors: [
          {
            title: 'Invalid record parameters',
            detail: "Validation failed: Last name can't be blank",
            code: '422'
          }
        ]
      }
    end
  end
end
