require "bcrypt"
class User < ApplicationRecord
    
    validates :user_name, :password_digest, :session_token, presence: true
    validates :session_token, uniqueness: true
    validates :password, length: { minimum: 6}, allow_nil: true

    after_initialize :ensure_session_token

    attr_reader :password
    
    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def self.reset_session_token!
        self.update!(session_token: self.class.generate_session_token)
        self.session_token
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)  
        bcrypt_password = BCrypt::Password.new(self.password_digest)  #self.password_digest is the only thing you can get from the database
        bcrypt_password.is_password?(password) 
    end

    def self.find_by_credentials(user_name, password)
        user = self.find_by(user_name: user_name)
        return nil if user.nil?
        user.is_password?(password) ? user : nil
    end

    private

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end
end