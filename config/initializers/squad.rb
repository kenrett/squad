Squad.secret_key_base = ENV["secret_key_base"]
Squad.uber_client_id = ENV["uber_client_id"]
Squad.uber_client_secret = ENV["uber_client_secret"]
Squad.uber_server_token = ENV["uber_server_token"]

Squad.require_keys("secret_key_base","uber_client_id","uber_client_secret","uber_server_token")