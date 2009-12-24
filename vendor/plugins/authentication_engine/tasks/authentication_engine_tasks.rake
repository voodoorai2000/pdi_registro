$LOAD_PATH.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib') if File.directory?(RAILS_ROOT + '/vendor/plugins/cucumber/lib')

namespace :authentication_engine do
  plugin_path = "vendor/plugins/authentication_engine"
  
  desc "Sync extra files form authentication engine"
  task :sync do
    system "rsync -rbv #{plugin_path}/app/controllers/application_controller.rb app/controllers"
    system "rsync -rbv #{plugin_path}/app/helpers/application_helper.rb app/helpers"
    system "rsync -ruv #{plugin_path}/app/helpers/layout_helper.rb app/helpers"
    system "rsync -rbv #{plugin_path}/app/views/layouts/application.html.erb app/views/layouts"
    system "rsync -ruv #{plugin_path}/config/authentication_engine.yml config"
    system "rsync -rbv #{plugin_path}/config/authorization_rules.rb config"
    system "rsync -rbv #{plugin_path}/config/database.yml config"
    system "rsync -rbv #{plugin_path}/config/environments config"
    system "rsync -ruv #{plugin_path}/config/initializers config"
    system "rsync -rbv #{plugin_path}/config/locales config"
    system "rsync -ruv #{plugin_path}/db/migrate db"
    system "rsync -ruv #{plugin_path}/public ."
  end

  begin
    require 'cucumber/rake/task'

    # Use vendored cucumber binary if possible. If it's not vendored,
    # Cucumber::Rake::Task will automatically use installed gem's cucumber binary
    vendored_cucumber_binary = Dir["#{RAILS_ROOT}/vendor/{gems,plugins}/cucumber*/bin/cucumber"].first

    Cucumber::Rake::Task.new({:features => 'db:test:prepare'}, "Run Features of authentication_engine with Cucumber") do |t|
      t.binary = vendored_cucumber_binary
      t.fork = true # You may get faster startup if you set this to false
      t.cucumber_opts = "--color --tags ~@wip --strict --format #{ENV['CUCUMBER_FORMAT'] || 'pretty'} #{plugin_path}/features"
      # t.profile = "authentication_engine"
    end
  rescue LoadError
    desc 'Cucumber rake task not available'
    task :features do
      abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
    end
  end

  namespace :state_machine do
    desc 'Draws a set of state machines using GraphViz. Target files to load with FILE=x,y,z; Machine class with CLASS=x,y,z; Font name with FONT=x; Image format with FORMAT=x; Orientation with ORIENTATION=x'
    task :draw do
      # Load the library
      $:.unshift(File.dirname(__FILE__) + '/lib')
      require 'state_machine'

      # Build drawing options
      options = {}
      options[:file] = ENV['FILE'] if ENV['FILE']
      options[:path] = "#{plugin_path}/public/images/"
      # options[:path] = ENV['TARGET'] if ENV['TARGET']
      options[:format] = ENV['FORMAT'] if ENV['FORMAT']
      options[:font] = ENV['FONT'] if ENV['FONT']
      options[:orientation] = ENV['ORIENTATION'] if ENV['ORIENTATION']

      StateMachine::Machine.draw("User", options)
    end

    namespace :draw do
      desc 'Draws a set of state machines using GraphViz for a Ruby on Rails application.  Target class with CLASS=x,y,z; Font name with FONT=x; Image format with FORMAT=x; Orientation with ORIENTATION=x'
      task :rails => [:environment, 'state_machine:draw']
    end
  end
end