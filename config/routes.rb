Rails.application.routes.draw do
  resources :employees, only: [:index, :show, :create]

  scope(path: 'employees/:employee_id',
    as: :employee,
    controller: :employees) do
      resources :assistances, only: [:index, :create]
  end

end
