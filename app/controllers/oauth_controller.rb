class OauthController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    Rails.logger.info "Got auth_hash: #{auth_hash}"

    if @authorization = Authorization.where(provider: auth_hash["provider"], uid: auth_hash["uid"]).first
      render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
    else
      user = User.create_from_auth_hash(auth_hash)
      render :text => "Hi #{user.name}! You've signed up."
    end
  end

  def failure
    render text: "Could not authorize with oauth!"
  end

end
