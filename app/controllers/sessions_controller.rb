class SessionsController < ApplicationController
  def create
    raise :test
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['amniauth.auth']
  end
end
