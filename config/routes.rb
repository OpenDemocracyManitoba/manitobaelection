Manitobaelection::Application.routes.draw do

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

  resources :maps, :only => [:index, :edit, :update]
  get 'maps/:id/:slug' => 'maps#show', :as => 'friendly_map', :constraints => { :id => /[0-9]+/ }

  resources :issues, :only => [:index]

  resources :news_articles, :only => [:index, :show, :update] do
    collection do
      get 'moderate'
      get 'moderate_approved'
    end
    get 'page/:page', :action => :index, :on => :collection
  end

  get 'constituencies/65/fort-whyte-2012-by-election' => redirect('/by-election-2012')
  get 'constituencies' => 'constituencies#index', :as => 'constituencies'
  get 'constituencies/:id/:slug' => 'constituencies#show', :as => 'constituency', :constraints => { :id => /[0-9]+/ } 

  get 'candidates' => 'politicians#index', :as => 'candidates' 
  get 'candidates/:id/:slug(/page/:page)' => 'politicians#show',  :as => 'candidate', :constraints => { :id => /[0-9]+/ }
  get 'candidates/incumbents' => 'politicians#incumbents', :as => 'incumbents'
  get 'candidates/questionnaires' => 'politicians#questionnaires'
  get 'candidates/tweets' => 'politicians#tweets'
  get 'candidates/contacts' => 'politicians#contacts'
  get 'twitterfollow' => 'politicians#twitter'

  get 'pages/:id/:slug' => 'pages#show', :as => 'friendly_page', :constraints => { :id => /[0-9]+/ }

  resources :parties, :only => [:index] 
  get 'parties/:id/:slug' => 'parties#show', :as => 'party', :constraints => { :id => /[0-9]+/ }

  get 'search' => 'info#search'
  get 'historic-maps' => 'info#historic'
  get 'election-2011' => "info#index", :as => 'election_2011'
  get 'by-election-2012' => "info#byelection_2012", :as => "byelection_2012"
  
  root :to => "info#index"
#  root :to => "info#byelection_2012"

end
