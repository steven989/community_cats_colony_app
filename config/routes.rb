Rails.application.routes.draw do


  resources :password_resets
  
  resources :user_sessions
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root to: 'users#login'
  get 'colonies/look_up_root' => 'colonies#look_up_root', as: 'look_up_colonies'
  post 'colonies/look_up_query' => 'colonies#look_up_query', as: 'look_up_query'
  get 'colonies/:id/edit' => 'colonies#edit', as: 'edit_colony'
  put 'colonies/:id/admin_update' => 'colonies#admin_update', as: 'admin_update_colony'
  get 'login' => 'users#login', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  get 'colonies/new' => 'colonies#new', as: 'new_colony'
  post 'colonies/create' => 'colonies#create', as: 'create_colony'
  delete 'colonies/:id' => 'colonies#destroy', as: 'delete_colony'
  get 'users/invite_user' => 'users#invite_user', as: 'invite_user'
  post 'users/send_invite' => 'users#send_invite', as: 'send_invite'
  resources :users
  delete 'users/delete_token/:id' => 'users#delete_token', as: 'delete_token'


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
