SquadApp.secret_key_base = ENV["secret_key_base"]
SquadApp.uber_client_id = ENV["uber_client_id"]
SquadApp.uber_client_secret = ENV["uber_client_secret"]
SquadApp.uber_server_token = ENV["uber_server_token"]

SquadApp.require_keys("secret_key_base","uber_client_id","uber_client_secret","uber_server_token")