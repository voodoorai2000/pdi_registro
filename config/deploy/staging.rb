
set :rails_env, 'staging'
 
role :app, "#{STAGING_SERVER_IP}"  
role :web, "#{STAGING_SERVER_IP}"  
role :db,  "#{STAGING_SERVER_IP}", :primary => true

set :deploy_to, "/var/www/apps/#{PROJECT_NAME}"
