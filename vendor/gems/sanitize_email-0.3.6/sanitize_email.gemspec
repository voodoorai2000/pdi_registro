# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sanitize_email}
  s.version = "0.3.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Boling", "John Trupiano", "George Anderson"]
  s.date = %q{2009-11-10}
  s.description = %q{Test an application's email abilities without ever sending a message to actual live addresses}
  s.email = ["peter.boling@gmail.com", "jtrupiano@gmail.com", "george@benevolentcode.com"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "init.rb",
     "lib/sanitize_email.rb",
     "lib/sanitize_email/custom_environments.rb",
     "lib/sanitize_email/sanitize_email.rb",
     "sanitize_email.gemspec",
     "test/sample_mailer.rb",
     "test/sanitize_email_test.rb"
  ]
  s.homepage = %q{http://github.com/pboling/sanitize_email}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Tool to aid in development, testing, qa, and production troubleshooting of email issues without worrying that emails will get sent to actual live addresses.}
  s.test_files = [
    "test/sample_mailer.rb",
     "test/sanitize_email_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionmailer>, [">= 0"])
    else
      s.add_dependency(%q<actionmailer>, [">= 0"])
    end
  else
    s.add_dependency(%q<actionmailer>, [">= 0"])
  end
end

