
set :rails_env, 'staging'
 
role :app, "209.20.72.136"  
role :web, "209.20.72.136"  
role :db,  "209.20.72.136", :primary => true

set :deploy_to, "/var/www/apps/pdi_registro"
