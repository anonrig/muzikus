Rails.application.routes.draw do
  root 'main#index'

  get 'main' => 'main#index'
  get 'aboutus' => 'main#aboutus', as: 'aboutus'
  get 'contactus' => 'main#contactus', as: 'contactus'
  get 'projects' => 'main#projects', as: 'projects'
  get 'bands' => 'main#bands', as: 'bands'
  get 'gallery' => 'main#gallery', as: 'gallery'
  get 'howto' => 'main#howto', as: 'howto'  

# admin panel    
  #teachers
  resources :teachers, except: [:show, :edit]

  #lessons
  get 'admin/lessons' => 'faculty_lessons#index', as: 'admin_lessons'
  post 'admin/lessons' => 'faculty_lessons#create'
  delete 'admin/lesson/:id' => 'faculty_lessons#destroy', as: 'admin_lesson'

# Alfonso
  get 'reservations' => 'reservations#index', as: 'reservations'
  post 'reservations' => 'reservations#create'
  delete 'reservations/:id' => 'reservations#destroy', as: 'reservation'
  
#SCOUT
  get 'scout/discover' => 'scout_profiles#index', as: 'scout'
  get 'scout/profile/:email' => 'users#show', as: 'profile'
  patch 'users/:id' => 'users#update'
  post 'users/scout' => 'scout_profiles#create'
  patch 'user/scout/:id' => 'scout_profiles#update'
  post 'user/scout/info' => 'musician_infos#create'
  patch 'user/scout/info/:id' => 'musician_infos#update'
  delete 'user/scout/deleteinfo/:id' => 'musician_infos#destroy', as: 'info_destroy'

  namespace :admin do
    get '/' => "main#index"
    get '/clear/sessions' => "main#sessions"
    get '/clear/reservations' => "main#reservations"
    
    #USERS
    get 'users/members' => 'users#members', as: 'members'
    get 'users/blocked' => 'users#blocked', as: 'blocked_users'
    resources :users, only: [:index, :create, :show, :update, :destroy]

    #ROOMS
    resources :rooms, only: [:index, :show]
    
    #MANAGERS
    resources :managers, only: [:index, :create, :destroy]

    #LESSONS / PROJECTS
    resources :faculty_lessons, only: [:index, :create, :destroy]

    #SCHEDULES
    resources :lesson_schedules, only: [:index, :create, :destroy]

    #RESERVATIONS
    resources :reservations, only: [:index]

    #BUDGET STATUS
    resources :budgets, only: [:index, :create]

    #EVENTS
    resources :events, only: [:new, :create]
  end


  resources :events, except: [:show]
  
  get 'auth/:provider/callback', to: "sessions#create"
  get 'auth/failure', to: redirect('/')
  get 'sign_out', to: "sessions#destroy", as: 'sign_out'

  namespace :api do
    post 'authenticate', to: 'authentication#authenticate'
    resources :events, only: [:index, :show]
    resources :reservations, only: [:index, :create, :destroy]
    resources :rooms, only: [:index, :show]
    get 'account/get' => 'account#get'
  end
end
