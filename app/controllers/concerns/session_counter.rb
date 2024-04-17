module SessionCounter
  extend ActiveSupport::Concern

  private
  def session_count
    session[:counter] ||= 0
    session[:counter] += 1
    @session_count = session[:counter]
  end

  def clear_session_count
    unless session[:counter].nil?
      session[:counter] = 0
    end
  end
end
