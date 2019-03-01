module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController

    protected

    def render_create_success
      render json: EmployeeSerializer.new(@resource).serialized_json, status: 200
    end

    def render_create_error_bad_credentials
      render json: {
        errors: [
          {
            title: 'Bad authentication',
            detail: 'Invalid login credentials',
            code: '401'
          }
        ]
      }, status: 401
    end

    def render_destroy_success
      render json: {
        meta: {
          copyright: 'Copyright 2019 RHA Corp',
          author: ['Guga Salazar']
        }
      }, status: 200
    end

    def render_destroy_error
      render json: {
        errors: [
          {
            title: 'Bad credentials',
            detail: 'User was not found or was not logged in',
            code: '404'
          }
        ]
      }, status: 404
    end
  end
  
end