Rails.application.routes.draw do
    get '/current_user', to: 'current_user#get_user'
    get '/current_author', to: 'current_user#get_author'
    
    get '/book/:id', to: 'books#show'
    post '/book', to: 'books#create'
    post '/book/add_cover', to: 'books#add_cover'
    put '/book', to: 'books#update'
    delete '/book', to: 'books#destroy'

    devise_for :users, path: 'user', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

    devise_for :authors, path: 'author', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'authors/sessions',
      registrations: 'authors/registrations'
    }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
