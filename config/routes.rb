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
  get 'admin' => 'admin#index'

  #users
  get 'admin/users' => 'users#index', as: 'admin_users'
  post 'admin/users' => 'users#create'
  delete 'admin/users/:id' => 'users#destroy', as: 'admin_user'

  #rooms
  get 'admin/rooms' => 'rooms#index', as: 'admin_rooms'
  post 'admin/rooms' => 'rooms#create'
  get 'admin/rooms/:id' => 'rooms#show', as: 'admin_room'
  delete 'admin/rooms/:id' => 'rooms#destroy'

  #schedules
  post 'admin/rooms/schedules' => 'lesson_schedules#create'
  delete 'admin/rooms/schedules/:id' => 'lesson_schedules#destroy', as: 'admin_schedule'

  #managers
  get 'admin/rooms/managers' => 'managers#index', as: 'admin_managers'
  post 'admin/rooms/managers' => 'managers#create'
  delete 'admin/rooms/managers/:id' => 'managers#destroy', as: 'admin_manager'

  #budget
  get 'admin/budget' => 'budgets#index', as: 'admin_budget'
  post 'admin/budget' => 'budgets#create'
  
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

#Events
  resources :events, except: [:show]
  
  get 'auth/:provider/callback', to: "sessions#create"
  get 'auth/failure', to: redirect('/')
  get 'sign_out', to: "sessions#destroy", as: 'sign_out'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #API routes
  namespace :api do
    resources :events, only: [:index, :show]
  end
end
