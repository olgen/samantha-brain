# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user:email,public_repo"
end

run Rails.application
