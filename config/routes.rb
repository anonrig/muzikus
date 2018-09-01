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
  get 'admin/users' => 'admin#users', as: 'admin_users'
  get 'admin/rooms' => 'admin#rooms', as: 'admin_rooms'
  get 'admin/managers' => 'admin#managers', as: 'admin_managers'
  get 'admin/facultylessons' => 'admin#lessons', as: 'admin_lessons'
  get 'admin/lessonschedule/:id' => 'admin#showschedule', as: 'admin_schedule'
  get 'admin/budgetstatus' => 'admin#budgetstatus', as: 'admin_budget'
  #create
  post 'admin/createuser'
  post 'admin/createroom'
  post 'admin/createmanager'
  post 'admin/createteacher'
  post 'admin/createlesson'
  post 'admin/createschedule'
  post 'admin/createbudget'
  #edit
  patch 'admin/updatemanager' => 'admin#updatemanager'
  post 'admin/updateroom' => 'admin#updateroom'
  post 'admin/updateteacher' => 'admin#updateteacher'
  #destroy
  delete 'admin/deleteroom/:id' => 'admin#deleteroom', as: 'admin_deleteroom'
  delete 'admin/deleteschedule/:id' => 'admin#deleteschedule', as: 'admin_deleteschedule'
  delete 'admin/deleteteacher/:id' => 'admin#deleteteacher', as: 'admin_deleteteacher'
  delete 'admin/deletelesson/:id' => 'admin#deletelesson', as: 'admin_deletelesson'
  delete 'admin/deleteuser/:id' => 'admin#deleteuser', as: 'admin_deleteuser'
  delete 'admin/deletemanager/:id' => 'admin#deletemanager', as: 'admin_deletemanager'
# Alfonso
  get 'reservations' => 'reservations#index', as: 'reservations'
  post 'reservation/create' => 'reservations#create'
  delete 'reservation/destroy/:id' => 'reservations#destroy', as: 'reservation_destroy'
#SCOUT
  get 'scout/discover' => 'scout_profiles#index', as: 'scout'
  get 'scout/profile/:email' => 'users#show', as: 'profile'
  #get 'users/profile/:id/settings' => 'user#usersettings', as: 'user_settings'
  patch 'users/:id' => 'users#update'
  post 'users/scout' => 'scout_profiles#create'
  patch 'user/scout/:id' => 'scout_profiles#update'
  post 'user/scout/info' => 'musician_infos#create'
  patch 'user/scout/info/:id' => 'musician_infos#update'
  delete 'user/scout/deleteinfo/:id' => 'musician_infos#destroy', as: 'info_destroy'

#Faculty
  get 'teachers' => 'teachers#index', as: 'teachers'

#Events
  get 'events/getAll' => 'events#get_all'
  resources :events
  
  get 'auth/:provider/callback', to: "sessions#create"
  get 'auth/failure', to: redirect('/')
  get 'sign_out', to: "sessions#destroy", as: 'sign_out'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
