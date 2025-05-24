class User < ApplicationRecord
  has_many :matrices,   dependent: :destroy
  has_many :vectors,    dependent: :destroy
  has_many :operations, dependent: :destroy
  has_many :audit_logs, dependent: :nullify

  has_secure_password

  validates :name,  presence: true, uniqueness: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }

  def generate_password_reset!
    token = SecureRandom.urlsafe_base64
    update!(
      reset_password_token:   token,
      reset_password_sent_at: Time.current
    )
  end

  def clear_reset_password_token!
    update!(reset_password_token: nil, reset_password_sent_at: nil)
  end

  def password_reset_period_valid?
    reset_password_sent_at && reset_password_sent_at > 2.hours.ago
  end
end
