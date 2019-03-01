# :nodoc:
module ExpectedResponseHelper
  # :nodoc:
  module Authorization
    def not_authorized_error
      {
        errors: [
          {
            title: 'Authorization error',
            detail: 'You are not authorized to perform this action',
            code: '403'
          }
        ]
      }
    end
  end
end