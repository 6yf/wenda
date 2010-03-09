# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_wenda_session',
  :secret => 'a6c5d5de9f47d7e0295b97f1438724402d79fcee2a3257aad2cf6405445cddea701b98d2f029f249a22cc8833ec3c08e91ce4ba633f2bf867a64350e7e0f216b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
