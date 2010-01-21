
set :rails_env, 'production'
role :app, "209.20.74.161"  
role :web, "209.20.74.161"  
role :db,  "209.20.74.161", :primary => true

set :deploy_to, "/var/www/apps/registro_pdi"

desc "create symbolic link to backup_fu.yml"
task :create_symbolic_links_for_backups, :roles => :app do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/backup_fu.yml #{release_path}/config/backup_fu.yml" 
end

after "deploy:update_code", "create_symbolic_links_for_backups"
