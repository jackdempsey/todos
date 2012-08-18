Rails.application.routes.draw do

  mount Todos::Engine => "/todos"
end
