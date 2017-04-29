Rails.application.routes.draw do
  resources :skills
  resources :lessons
  devise_for :users, controllers: { registrations: 'registrations' }

  root to: 'home#index'
  get '/lessons/:id/confirm', to: 'lessons#confirm', as: 'confirm_lesson'
  get '/my_lessons', to: 'lessons#my_lessons'
  get '/lessons/:id/rating', to: 'lessons#lesson_rating', as: 'lesson_rating'
  get 'hello_world', to: 'hello_world#index'
  patch '/lessons/:id/add_rating', to: 'lessons#add_rating', as: 'add_rating'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
