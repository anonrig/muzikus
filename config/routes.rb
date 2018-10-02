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
  #users
  get 'admin/users' => 'users#index', as: 'admin_users'
  post 'admin/users' => 'users#create'
  delete 'admin/users/:id' => 'users#destroy', as: 'admin_user'

  #rooms
  get 'admin/rooms' => 'rooms#index', as: 'admin_rooms'
  post 'admin/rooms' => 'rooms#create'
  delete 'admin/rooms/:id' => 'rooms#destroy', as: 'admin_room'

  #managers
  get 'admin/rooms/managers' => 'managers#index', as: 'admin_managers'
  post 'admin/rooms/managers' => 'managers#create'
  delete 'admin/rooms/managers/:id' => 'managers#destroy', as: 'admin_manager'

  #budget
  get 'admin/budget' => 'budgets#index', as: 'admin_budget'
  post 'admin/budget' => 'budgets#create'

  get 'admin' => 'admin#index'
  get 'admin/facultylessons' => 'admin#lessons', as: 'admin_lessons'
  get 'admin/lessonschedule/:id' => 'admin#showschedule', as: 'admin_schedule'
  #create
  post 'admin/createteacher'
  post 'admin/createlesson'
  post 'admin/createschedule'
  #edit
  post 'admin/updateteacher' => 'admin#updateteacher'
  #destroy
  delete 'admin/deleteschedule/:id' => 'admin#deleteschedule', as: 'admin_deleteschedule'
  delete 'admin/deleteteacher/:id' => 'admin#deleteteacher', as: 'admin_deleteteacher'
  delete 'admin/deletelesson/:id' => 'admin#deletelesson', as: 'admin_deletelesson'
# Alfonso
  get 'reservations' => 'reservations#index', as: 'reservations'
  post 'reservation/create' => 'reservations#create'
  delete 'reservation/destroy/:id' => 'reservations#destroy', as: 'reservation_destroy'
#SCOUT
  get 'scout/discover' => 'scout_profiles#index', as: 'scout'
  get 'scout/profile/:email' => 'users#show', as: 'profile'
  patch 'users/:id' => 'users#update'
  post 'users/scout' => 'scout_profiles#create'
  patch 'user/scout/:id' => 'scout_profiles#update'
  post 'user/scout/info' => 'musician_infos#create'
  patch 'user/scout/info/:id' => 'musician_infos#update'
  delete 'user/scout/deleteinfo/:id' => 'musician_infos#destroy', as: 'info_destroy'

#Faculty
  get 'teachers' => 'teachers#index', as: 'teachers'

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
