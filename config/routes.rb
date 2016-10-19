Rails.application.routes.draw do
  root 'person#index'

  get 'game/new'
  post 'game/create'
  get 'people', to: 'person#list'
end
