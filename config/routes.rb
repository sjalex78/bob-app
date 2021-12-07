Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products do
    member do
      post 'toggle_category'
      post 'toggle_business'
      post 'toggle_cost'
      get 'add_to_list'
      post 'create_solution_from_product'
    end
  end
  resources :lists do
    resources :solutions, only: %i[new create]
    resources :contributors, only: %i[index new create] do
      member do
        post 'remove'
      end
    end
    resources :products do
      member do
        post 'toggle_vote'
      end
      resources :solutions, only: :create, controller:'lists/products/solutions'
    end
  end
  resources :solutions, only: :destroy
end
