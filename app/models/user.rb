class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  
  before_save { self.email = email.downcase } # forces email to be lowercase, self.email = self.email.downcase
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # use Rubular website to find this
  validates :email, presence: true, length: { maximum: 255 }, 
          format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
          
  validates :password, presence:true, length: { minimum: 6 }
  has_secure_password
end
