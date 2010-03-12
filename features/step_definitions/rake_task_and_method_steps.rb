Cuando /^ejecuto la tarea "([^\"]*)"$/ do |task|
  system "rake #{task}"
end

Cuando /^ejecuto el metodo para renviar el email de activacion$/ do
  User.resend_activation_email
end
