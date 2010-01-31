
set :rails_env, 'production'
role :app, "209.20.94.182"  
role :web, "209.20.94.182"  
role :db,  "209.20.94.182", :primary => true

set :deploy_to, "/var/www/apps/pdi_registro"

desc "create symbolic link to backup_fu.yml"
task :create_symbolic_links_for_backups, :roles => :app do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/backup_fu.yml #{release_path}/config/backup_fu.yml" 
end

after "deploy:update_code", "create_symbolic_links_for_backups"
