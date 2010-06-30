ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'users', :action => 'new', :conditions => { :method => :get }
  map.namespace :admin do |admin|
    admin.root :controller => "home", :action => "dashboard"
    admin.resources :areas
  end
  map.with_options :controller => 'info' do |info|
    info.about 'legal_conditions', :action => 'legal_conditions'
    info.afiliate 'info/afiliate', :action => 'afiliate'
  end
  
  map.ranking "/ranking", :controller => "ranking"
  map.dashboard "/dashboard", :controller => "dashboard"
    
 
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
