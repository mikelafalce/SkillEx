Rails.application.routes.draw do
  resources :skills
  resources :lessons
  devise_for :users, controllers: { registrations: 'registrations' }

  root to: 'home#index'
  get '/lessons/:id/confirm', to: 'lessons#confirm', as: 'confirm_lesson'
  get '/my_lessons', to: 'lessons#my_lessons'

  get 'hello_world', to: 'hello_world#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
