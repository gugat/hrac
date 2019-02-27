Rails.application.routes.draw do

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
