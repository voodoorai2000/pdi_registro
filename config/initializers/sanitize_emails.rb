require 'sanitize_email'
ActionMailer::Base.sanitized_recipients = "voodoorai2000@gmail.com"
ActionMailer::Base.sanitized_bcc = nil
ActionMailer::Base.sanitized_cc = nil

# optionally, you can configure sanitize_email to include the "real" email address as the 'user name' of the
# "sanitized" email (e.g. "real@address.com <sanitized@email.com>")
ActionMailer::Base.use_actual_email_as_sanitized_user_name = true # defaults to false

# These are the environments whose outgoing email BCC, CC and recipients fields will be overridden!
# All environments not listed will be treated as normal.
ActionMailer::Base.local_environments = %w( development test staging )