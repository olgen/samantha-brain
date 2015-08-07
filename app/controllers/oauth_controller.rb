class OauthController < ApplicationController

  def create
    render text: "Got env: #{env}", template: false
  end

end
