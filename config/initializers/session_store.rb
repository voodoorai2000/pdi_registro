# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_authlogic_session',
  :secret      => 'bc595f4948656677af36cc7aaff78f8f4b650dce4f9ca1a83d24b3ca2cd6f3c1a690bd6ef741e75bafd977ef2724480d99841ae28171306629d4916c4e563424'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
