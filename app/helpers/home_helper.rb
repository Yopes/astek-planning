module HomeHelper
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.token]
    current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def admin?
    !current_user.nil? and current_user.admin
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  private

  def user_from_remember_token
    User.auth_with_cookie(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
end
