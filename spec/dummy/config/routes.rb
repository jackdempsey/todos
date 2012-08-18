Rails.application.routes.draw do
  get "home/index"

  root to: 'home#index'


  mount Todos::Engine => "/todos"
end
