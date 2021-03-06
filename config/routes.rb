Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get 'signin' => 'home#new'
  post 'signin' => 'home#create'

  get 'signup' => 'users#new'
  post 'users' => 'users#create'

  get 'users/:id/edit' => 'users#edit'
  patch 'users/:id/update' => 'users#update'
  get 'users/:id/delete' => 'users#delete'

  get 'logout' => 'home#destroy'

  get 'invitations' => 'invitations#new'
  post 'invitations' => 'invitations#create'


  get 'planning' => 'planning#index'
  get 'planning/week' => 'planning#week'
  get 'planning/month' => 'planning#month'

  get 'directory' => 'users#index'

  post 'jobs' => 'planning#create_job'
  post 'jobs/:id' => 'planning#update_job'
  get 'jobs/:id/delete' => 'planning#delete_job'
  post 'tasks' => 'planning#create_task'
  post 'tasks/:id' => 'planning#update_task'
  get 'tasks/:id/delete' => 'planning#delete_task'

  get 'search_users' => 'users#search_users', defaults: { format: :json } 

  get 'search_tasks' => 'planning#search_tasks', defaults: { format: :json } 
  
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
