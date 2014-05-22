class User < ActiveRecord::Base
  has_many :attended_concerts
  has_many :concerts, through: :attended_concerts

  has_secure_password

  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-\.]+@[a-z\d\-\.]+\.[a-z]+\z/i

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false }

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }

end
