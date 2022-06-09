class ApplicationController < ActionController::Base
  def current_user
    raise 'Never call this method. Call current_user_identifier instead'
  end

  def authenticate_user!
    raise 'Not Implemented Error. Should be implemented in each component ApplicationController.'
  end
end
