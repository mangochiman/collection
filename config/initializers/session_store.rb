# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_collection_session',
  :secret      => '9797298119035dd32ee79b224b487b229e9b474c736d8e6016e2e6557a4b685ca0b359b4457422d9ddaf3bc72b8b80e5c1db22317afe915c6f5f044eb052bcdb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
