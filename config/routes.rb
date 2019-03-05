Rails.application.routes.draw do
  mount_devise_token_auth_for 'Employee',
                              at: 'auth',
                              skip: %i[registrations],
                              controllers: {
                                sessions: 'overrides/sessions'
                              }

  #
  # Api documentation
  #
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    # Resources
    resources :employees, only: [:index, :show, :create]
    scope(path: 'employees/:employee_id',
          as: :employee,
          controller: :employees) do
      resources :assistances, only: [:index, :create]
    end
    # Reports
    get '/reports/:employee_id/journeys', to: 'reports/journeys#show', as: 'journey_report'
    # Schemas
    get 'schemas/:name', to: 'schemas#show', as: 'schema'
  end
end
