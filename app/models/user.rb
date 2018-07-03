class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  USER_ATTRS = %w(name email password password_confirmation).freeze

  validates :email, presence: true,
    length: {maximum: Settings.length.max_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :name, presence: true,
    length: {maximum: Settings.length.max_name}
  validates :password, presence: true,
    length: {minimum: Settings.length.min_pass}

  before_save :email_downcase

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end
  end

  private

  def email_downcase
    email.downcase!
  end
end
