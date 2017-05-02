Rails.application.routes.draw do
  resources :skills
  resources :lessons
  devise_for :users, controllers: { registrations: 'registrations' }
  authenticated :user do
    root 'home#index', as: :root #-> if user is logged in
    resources :controller #-> ONLY available for logged in users
  end

  unauthenticated :user do
    root 'home#landing', as: :unauthenticated #-> if user is not logged in
  end

  root to: 'home#index'
  get '/lessons/:id/confirm', to: 'lessons#confirm', as: 'confirm_lesson'
  get '/upcoming_lessons', to: 'lessons#my_upcoming_lessons', as: 'upcoming_lessons'
  get '/my_skills', to: 'skills#my_skills', as: 'my_skills'
  get '/lessons/:id/rating', to: 'lessons#lesson_rating', as: 'lesson_rating'
  get 'hello_world', to: 'hello_world#index'
  patch '/lessons/:id/add_rating', to: 'lessons#add_rating', as: 'add_rating'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
