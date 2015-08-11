require 'uri'
require 'jwt'

class OauthController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    Rails.logger.info "Got auth_hash: #{auth_hash}"

    if @authorization = Authorization.where(provider: auth_hash["provider"], uid: auth_hash["uid"]).first
      @user = @authorization.user
      Rails.logger.info "Welcome back #{@authorization.user.name}! You have already signed up."
    else
      @user = User.create_from_auth_hash(auth_hash)
      Rails.logger.info "Hi #{user.name}! You've signed up."
    end
    redirect_to_frontend()
  end

  def failure
    render text: "Could not authorize with oauth!"
  end

  protected

  def redirect_to_frontend
    user_hash = @user.attributes.slice(:id, :name, :email)
    jwt = JWT.encode(user_hash, ENV['JWT_SECRET'])
    frontend_url = URI.join(ENV['FRONTEND_HOST'], "/dashboard?jwt=#{jwt}").to_s
    redirect_to frontend_url
  end

end
