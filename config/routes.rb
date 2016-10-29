Rails.application.routes.draw do
  root 'leaderboard#index'

  get 'game/new'
  post 'game/create'
  get 'people', to: 'person#list'
end
