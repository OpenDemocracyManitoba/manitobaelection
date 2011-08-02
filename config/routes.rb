Manitobaelection::Application.routes.draw do
  resources :news_articles, :only => [:index, :show, :update] do
    collection do
      get 'moderate'
    end
  end

  ActiveAdmin.routes(self)
  # Manual routes are required because of routing error that crops up for resources that use multipart forms with paperclip gem.
  post '/admin/parties/:id' => 'admin/parties#update'
  get '/admin/parties/:id'   => 'admin/parties#show'
  put '/admin/parties' => 'admin/parties#create'

  post '/admin/politicians/:id' => 'admin/politicians#update'
  get '/admin/politicians/:id'   => 'admin/politicians#show'
  put '/admin/politicians' => 'admin/politicians#create'

  post '/admin/constituencies/:id' => 'admin/constituencies#update'
  get '/admin/constituencies/:id'   => 'admin/constituencies#show'
  put '/admin/constituencies' => 'admin/constituencies#create'

  post '/admin/maps/:id' => 'admin/maps#update'
  get '/admin/maps/:id'   => 'admin/maps#show'
  put '/admin/maps' => 'admin/maps#create'

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :maps, :only => [:show, :edit, :update]
  resources :parties, :only => [:index,:show] 
#  resources :constituencies, :only => [:index,:show]
  get 'constituencies' => 'constituencies#index', :as => 'constituencies'
  get 'constituencies/:id/:slug' => 'constituencies#show', :as => 'constituency', :constraints => { :id => /[0-9]+/ } 

# resources :politicians, :only => [:index,:show] 
  get 'candidates' => 'politicians#index', :as => 'candidates' 
  get 'candidates/:id/:slug' => 'politicians#show',  :as => 'candidate', :constraints => { :id => /[0-9]+/ }
  get 'candidates/incumbents' => 'politicians#incumbents', :as => 'incumbents'

  get 'pages/:id/:slug' => 'pages#show', :as => 'friendly_page', :constraints => { :id => /[0-9]+/ }

  
  root :to => "info#index"

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
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
