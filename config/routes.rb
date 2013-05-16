BabyBrewster::Application.routes.draw do
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'auth/facebook/callback', to: 'sessions#callback'
  match 'signout', to: 'sessions#destroy'
  root to: 'home#index'

  resources :friends do
    collection do
      get 'search'
    end
  end

  resources :users do
    member do
      get 'city'
      get 'mutual'
      get 'college'
      get 'high_school'
      get 'grad_school'
      get 'friends'
    end
  end
end
