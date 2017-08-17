require 'bcrypt'

# helper module for authenticating requests
module AuthenticationHelper
  include BCrypt

  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && credentialed?
  end

  def credentialed?
    user = DB[:users].find(user: @auth.credentials.first).first
    Password.new(user[:password_hash]) == @auth.credentials.last
  end
end
