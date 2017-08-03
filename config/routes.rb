Rails.application.routes.draw do
  root 'leaderboard#index'

  get 'game/new'
  post 'game/create'
  get 'people', to: 'person#list'
  scope 'stats' do
    get 'fact', to: 'stats#fact'
  end

  get '/u/:id', to: 'person#show', as: 'person'

  get '/notloggedin', to: 'sessions#new', as: 'login'
  get '/notallowed', to: 'sessions#denied', as: 'not_allowed'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
