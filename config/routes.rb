Alfonsoapp::Application.routes.draw do


  resources :subjects
  mount Ckeditor::Engine => '/ckeditor'
  resources :posts
  get "scout", to: 'scout#index', as: 'scout'
  get "scout/new", as: 'new_scout'
  post "scout/create", as: 'create_scout'
  get "scout/edit", as: 'edit_scout'
  
  get "sessions/create"
  get "sessions/destroy"
  root :to => 'main#index'
  
  match '/contactus' => 'main#contactus', via: :get, :as => 'contactus'
  match '/contactus' => 'main#contactsubmit', via: :post, :as =>'submit_contactus'
  match '/howto' => 'main#howto', via: :get, :as => 'howto'
  match '/system' => 'main#system', via: :get, :as => 'system'
  match '/aboutus' => 'main#aboutus', via: :get, :as => 'aboutus'
  match '/mail' => 'main#mail', via: :get, :as => 'mail'
  match '/mail' => 'main#createmail', via: :post, :as => 'submit_mail'
  
  match '/events' => 'main#events', via: :get, :as => 'events'
  match '/faculty' => 'main#faculty', via: :get, :as => 'faculty'
  match '/rooms' => 'main#rooms', via: :get, :as => 'rooms'
  match '/projects' => 'main#projects', via: :get, :as => 'projects'
  match '/bands' => 'main#bands', via: :get, :as => 'bands'
  #match '/gallery' => 'main#gallery', via: :get, :as => 'gallery'
  match '/gallery' => 'main#gallery', via: :get, :as => 'gallery'
  match '/faq' => 'main#faq', via: :get, :as => 'faq'
  
  match 'auth/:provider/callback' => 'sessions#create', via: :get
  match 'auth/failure' => redirect('/'), via: :get
  match 'signout' => 'sessions#destroy', :as => 'signout', via: :get

  match 'reservations' => 'reservations#index', via: :get, :as => 'reservation'
  match 'reservations/new' => 'reservations#new', via: :get, :as => 'new_reservation'
  match 'reservations/new' => 'reservations#create', via: :post, :as => 'create_reservation'
  #delete 'reservations/delete/:id' => 'reservations#delete'
  match 'reservations/delete/:id' => 'reservations#delete', via: :delete, :as => 'reservation_delete'
  #resources: :reservations, :only => [:delete]
  
  get "admin/users"
  get "admin/budget"
  post "admin/createuser"
  post "admin/deleteuser"
  post "admin/addbudget"
  get "admin/support"
  post "admin/supportdelete"
  get "admin/muzikus"
  get "admin/edit/:id" => 'admin#edit'
  post "admin/edit/" => 'admin#editSubmit'
  get "admin/log" => 'admin#log'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
