class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  before_validation :ensure_session_token

  def password=(new_pass)
    password_digest = BCrypt::Password.create(new_pass)
    @password = new_pass
  end

  def is_password?(new_pass)
    pass_obj = BCrypt::Password.new(self.password_digest)
    pass_obj.is_password?(new_pass) 
  end

  def ensure_session_token
    session_token ||= SecureRandom::urlsafe_base64
  end





end
