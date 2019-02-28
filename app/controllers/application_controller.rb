class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ExceptionHandler


  def authenticate_employee!
    # puts request.headers.each { |key, value|  }
    # logger.info request.headers.each { |key, value|  }
    # https://github.com/lynndylanhurley/devise_token_auth/blob/7b9fddec85aa6e3578460d0ab12df51b29c92a86/lib/devise_token_auth/controllers/helpers.rb
    unless current_employee
      return render json: {
        errors: [
          {
            title: "Missing Authentication",
            detail: 'You need to sign in or sign up before continuing',
            code: '401'
          }
        ]
      }, status: '401'
    end
  end

end
