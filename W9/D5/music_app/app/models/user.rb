class User < ApplicationRecord

  validates 
  validates 
  validates 
  attr_reader :password

  after_initialize 
  after_initialize 

  has_many 

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    if user && user.is_password?(password)
      return user
    end
    nil
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
  # def set_activation_token
    
  # end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password) 
    
  end

  def is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  ##
  # This method is for the mailer!
  ##
  # def generate_unique_activation_token

  # end

  # def activate!
    
  # end
end
