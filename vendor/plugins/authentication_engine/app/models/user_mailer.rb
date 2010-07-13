class UserMailer < ActionMailer::Base
  default_url_options[:host] = NOTIFIER[:host]

  def activation_instructions(user)
    subject       "Instrucciones De Activación Partido de Internet"
    from          "#{NOTIFIER[:email]}"
    recipients    "#{user.email}"
    sent_on       Time.now
    body          :account_activation_url => activate_url(:activation_code => user.perishable_token)
  end

  def activation_confirmation(user)
    subject       "Activación Completa"
    from          "afiliacion@partidodeinternet.es"
    recipients    "#{user.email}"
    sent_on       Time.now
    body          :afiliation_url => afiliate_url
  end

  def password_reset_instructions(user) 
    subject       "Instrucciones Para Resetear Su Contraseña"
    from          "#{NOTIFIER[:email]}"
    recipients    "#{user.email}"
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def invitation(invitation, signup_url)
    subject       "Invitación De Usuario"
    from          "#{NOTIFIER[:email]}"
    recipients    "#{invitation.recipient_email}"
    sent_on       Time.now
    body          :invitation => invitation, :signup_url => signup_url

    invitation.update_attribute(:sent_at, Time.now)
  end

  def invitation_request(invitation)
    subject       "Petición De Invitación"
    from          "#{invitation.applicant_email}"
    recipients    "#{ADMIN[:email]}"
    sent_on       Time.now
    body          :invitation => invitation
  end

  def invitation_activation_notice(user)
    subject       'Invitación Activada'
    from          "#{NOTIFIER[:email]}"
    recipients    "#{user.invitation.sender.email}"
    sent_on       Time.now
    body          :user => user
  end

end
