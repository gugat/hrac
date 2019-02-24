module ExceptionHandler

  extend ActiveSupport::Concern

  included do

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { 
        errors: [
          error: {
            title: 'Employee not found',
            detail: e.message,
            code: '404'
          }
        ]
      }, status: 404
    end
   
    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { 
        errors: [
          error: {
            title: 'Invalid employee parameters',
            detail: e.message,
            code: '422'
          }
        ]
      }, status: 422
    end

  end
end