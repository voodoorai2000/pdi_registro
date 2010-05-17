require File.expand_path(File.dirname(__FILE__) + '/environment')
ssh_options[:keys] = %w(~/.ssh/id_rsa)
default_environment["PATH"] = "/opt/ruby-enterprise-1.8.7-2010.01/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'
 
default_run_options[:pty] = true 

set :keep_releases, 10

set :scm, :git
set :repository,  "git@github.com:voodoorai2000/pdi_registro.git"
set :branch, "master"
set :deploy_via, :checkout

set :user, "deploy"
set :port, "22"  
set :runner, "deploy"
set :use_sudo, false

desc "create symbolic links for files outside of version control"
task :create_symbolic_links, :roles => :app do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/authentication_engine.yml #{release_path}/config/authentication_engine.yml"
  run "ln -nfs #{deploy_to}/#{shared_dir}/db/schema.rb #{release_path}/db/schema.rb"
  run "ln -nfs #{deploy_to}/#{shared_dir}/images/bnn_home.jpg #{release_path}/public/images/bnn_home.jpg"
end

desc "Restart Application"
task :restart do
  run "touch #{current_path}/tmp/restart.txt"
end
  
  
namespace :deploy do
  %w(start restart).each { |name| task name, :roles => :app do mod_rails.restart end }

end

namespace :mod_rails do
  desc <<-DESC
  Restart the application altering tmp/restart.txt for mod_rails.
  DESC
  task :restart, :roles => :app do
    run "touch  #{current_path}/tmp/restart.txt"
  end
end

after "deploy:update_code", "create_symbolic_links"
#after "deploy:update", "passenger:restart"
after "deploy:update", "deploy:cleanup" 


Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'
