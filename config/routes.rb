Rails.application.routes.draw do
  get 'main/login'
  post 'main/create'
  get 'main/destroy'
  resources :scores
  resources :students
  get '/students/:id/edit_score', to: 'students#edit_score', as: 'edit_score_student'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
