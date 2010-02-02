ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'users', :action => 'new', :conditions => { :method => :get }
  map.namespace :admin do |admin|
    admin.root :controller => "home", :action => "dashboard"
    admin.resources :areas
  end
  map.with_options :controller => 'info' do |info|
    info.about 'terms_of_service', :action => 'terms_of_service'
  end
  
  map.ranking "/ranking", :controller => "ranking"
  map.dashboard "/dashboard", :controller => "dashboard"
    
 
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
