Rails.application.routes.draw do
  root 'person#index'

  get 'game/new'
  post 'game/create'
end
