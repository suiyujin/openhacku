class AuthenticationTokensController < ApplicationController
  before_action :authenticate_user!

  def update
    token = current_user.generate_authentication_token
    render json: {token: token}.to_json
  end

  def destroy
    current_user.delete_authentication_token
    render json: {message: 'logout successfull.'}.to_json
  end
end
