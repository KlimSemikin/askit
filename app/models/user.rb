# frozen_string_literal: true

class User < ApplicationRecord
  include Recoverable
  include Rememberable

  enum role: { basic: 0, moderator: 1, admin: 2 }, _suffix: :role

  attr_accessor :old_password, :skip_old_password

  has_secure_password validations: false

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy

  validate :correct_old_password, on: :update, if: -> { password.present? && !skip_old_password }

  validates :password, confirmation: true, allow_blank: true,
                       length: { minimum: 8, maximum: 70 }
  validate :password_presence, :password_complexity
  validate :new_password_not_old, on: :update, if: -> { !skip_old_password }

  validates :email, presence: true, uniqueness: true, email: true
  validates :role, presence: true

  before_save :set_gravatar_hash, if: :email_changed?

  def guest?
    false
  end

  def author?(obj)
    obj.user == self
  end

  private

  def set_gravatar_hash
    return if email.blank?

    self.gravatar_hash = Digest::MD5.hexdigest email.strip.downcase
  end

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost:)
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'is incorrect'
  end

  def new_password_not_old
    return unless BCrypt::Password.new(password_digest_was).is_password?(password)

    errors.add :password, 'is same like old'
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

    msg = 'complexity requirement not met. Length should be 8-70 characters and' \
          'include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
    errors.add :password, msg
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end
end
