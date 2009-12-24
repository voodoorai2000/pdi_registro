class Authorization::Engine
  # disable the RAILS_ENV condition check
  # so that you can have correct merged rules in development mode
  # ex: Article.with_permissions_to(:edit).all 
  def self.instance (dsl_file = nil)
    if dsl_file #or ENV['RAILS_ENV'] == 'development'
      @@instance = new(dsl_file)
    else
      @@instance ||= new
    end
  end
end