module ExpectedResponseHelper

  module Employee

    def found_employee_message(employee)
      {
        data: {
          id: employee.id.to_s,
          type: 'employee',
          attributes: {
            first_name: employee.first_name,
            last_name: employee.last_name
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
            last_name: valid_attributes[:last_name]
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


  # def employee_not_found_error()
  #   {
  #     errors: [
  #       {
  #         error: {
  #           title: 'Employee not found',
  #           detail: "Couldn't find Employee with 'id'=#{employee_id}"
  #         }
  #       }
  #     ]
  #   }
  # end
end