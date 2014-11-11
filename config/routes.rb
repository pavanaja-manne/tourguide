TourGuide::Application.routes.draw do
  
  get "users/profile"
  root :to => 'guides#index'
  match "/guides/display" => 'guides#display'
  match '/guides/delete' => 'guides#delete'
  match "/guides/location_create" => 'guides#location_create'
  match "/auth/facebook/callback" => "sessions#create"
  match '/guides/search' => 'guides#search'
  match '/guides/search_category' => 'guides#search_category'
  match '/guides/publish_guide' => 'guides#publish_guide'
  match "/users/profile" => 'users#profile'
  match '/create_location' => 'guides#location_create'#_fsq'
  match "/delete_location" => "guides#location_delete_fsq"
  match "/users/unfollow_user" => "users#unfollow_user"
  match "/users/follow_user" => 'users#follow_user'
  match "/users/follow_users_details" => "users#follow_users_details"
  #match '/:name' => 'users#profile' , :constraints => { :name => /[a-zA-Z0-9\-_]*/ }, :as => :user
  resources :guides do
      resources :locations
  end
  resources :users do
    member do
      get :following, :followers
      post :follow_user, :unfollow_user, :follow_users_details
    end
  end
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
end
