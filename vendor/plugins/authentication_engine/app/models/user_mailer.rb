class UserMailer < ActionMailer::Base
  default_url_options[:host] = NOTIFIER[:host]

  def activation_instructions(user)
    subject       "Instrucciones De Activación Partido de Internet"
    from          "#{NOTIFIER[:name]} <#{NOTIFIER[:email]}>"
    recipients    "#{user.name} <#{user.email}>"
    sent_on       Time.now
    body          :account_activation_url => activate_url(:activation_code => user.perishable_token)
  end

  def activation_confirmation(user)
    subject       "Activación Completa"
    from          "#{NOTIFIER[:name]} <#{NOTIFIER[:email]}>"
    recipients    "#{user.name} <#{user.email}>"
    sent_on       Time.now
    body          :afiliation_url => afiliate_url
  end

  def password_reset_instructions(user) 
    subject       "Instrucciones Para Resetear Su Contraseña"
    from          "#{NOTIFIER[:name]} <#{NOTIFIER[:email]}>"
    recipients    "#{user.name} <#{user.email}>"
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def invitation(invitation, signup_url)
    subject       "Invitación De Usuario"
    from          "#{NOTIFIER[:name]} <#{NOTIFIER[:email]}>"
    recipients    "#{invitation.recipient_name} <#{invitation.recipient_email}>"
    sent_on       Time.now
    body          :invitation => invitation, :signup_url => signup_url

    invitation.update_attribute(:sent_at, Time.now)
  end

  def invitation_request(invitation)
    subject       "Petición De Invitación"
    from          "#{invitation.applicant_name} <#{invitation.applicant_email}>"
    recipients    "#{ADMIN[:name]} <#{ADMIN[:email]}>"
    sent_on       Time.now
    body          :invitation => invitation
  end

  def invitation_activation_notice(user)
    subject       'Invitación Activada'
    from          "#{NOTIFIER[:name]} <#{NOTIFIER[:email]}>"
    recipients    "#{user.invitation.sender.name} <#{user.invitation.sender.email}>"
    sent_on       Time.now
    body          :user => user
  end

end
