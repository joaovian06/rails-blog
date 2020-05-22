Rails.application.routes.draw do
  get 'welcome/index'

  resources :articles do
    rsources :comments
  end

  root 'welcome#index'
end
