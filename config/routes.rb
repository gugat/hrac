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

  scope 'api-docs/v1' do
    get 'schemas/:name', to: 'schemas#show', as: 'schema'
  end

  #
  # Resources
  #

  resources :employees, only: [:index, :show, :create]

  scope(path: 'employees/:employee_id',
        as: :employee,
        controller: :employees) do
    resources :assistances, only: [:index, :create]
  end

end
