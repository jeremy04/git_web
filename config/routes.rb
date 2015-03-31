Rails.application.routes.draw do
  resources :bugs, only: [:show]
  resources :commits, only: [:index]

  scope :module => 'search' do
    get '/search'  => :search, as: :search
  end
  
  root to: "commits#index"
end
