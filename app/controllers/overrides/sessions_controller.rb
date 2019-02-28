# module Overrides
#   class SessionsController < DeviseTokenAuth::SessionsController

#     # protected
#     def render_new_error

#     end

#   end
# end

module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController

    protected
    def render_create_error_bad_credentials
      render json: {
        errors: [
          {
            title: 'Bad authentication',
            detail: 'Invalid login credentials',
            code: 402
          }
        ]
      }, status: 402
    end
  end
  
end