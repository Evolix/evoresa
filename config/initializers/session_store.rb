# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_evoresa2_session',
  :secret      => 'ef210f24cc7de77bcae2e22eabb805b106142d9ce41ea35fbc76b6b16657014df12e890eb2230847d45fb0f07c9f733db9a788c47eac7d4dcf83a3e862d43003'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
