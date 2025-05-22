class User < ApplicationRecord
  has_many :matrices,   dependent: :destroy
  has_many :vectors,    dependent: :destroy
  has_many :operations, dependent: :destroy
  has_many :logs,       dependent: :nullify

  has_secure_password

  validates :name,  presence: true, uniqueness: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
end
