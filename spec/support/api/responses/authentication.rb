# :nodoc:
module ExpectedResponseHelper
  # :nodoc:
  module Authentication

    def login_error
      {
        errors: [
          {
            title: 'Bad authentication',
            detail: 'Invalid login credentials',
            code: '401'
          }
        ]
      }
    end

    def logout_error
      {
        errors: [
          {
            title: 'Bad credentials',
            detail: 'User was not found or was not logged in',
            code: '404'
          }
        ]
      }
    end

    def logout_success
      {
        meta: {
          copyright: 'Copyright 2019 RHA Corp',
          'author': ['Guga Salazar']
        }
      }
    end
  end
end