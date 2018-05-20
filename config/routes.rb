Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'transactions#new'
  resources :transactions do
    collection do
      delete 'destroy_many', to: 'transactions#destroy_many'
    end
  end
  resources :account_summary
  
end
