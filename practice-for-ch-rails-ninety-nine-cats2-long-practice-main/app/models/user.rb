class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6}, allow_nil: true
  before_validation :ensure_session_token

  attr_reader :password
  def password=(new_pass)
    self.password_digest = BCrypt::Password.create(new_pass)
    @password = new_pass
  end

  def is_password?(new_pass)
    pass_obj = BCrypt::Password.new(self.password_digest)
    pass_obj.is_password?(new_pass) 
  end

  def ensure_session_token
    self.session_token ||= generate_unique_session_token
  end

  def reset_session_token!
    self.session_token = generate_unique_sesion_token
    self.save!
    self.session_token
  end

  def self.find_by_credential(username, password)
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  private
  def generate_unique_session_token
    SecureRandom::urlsafe_base64
  end
end
