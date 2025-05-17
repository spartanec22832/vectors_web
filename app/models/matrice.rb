class Matrix < ApplicationRecord
  belongs_to :user
  has_many   :operations, dependent: :nullify

  validates :matrix_data, presence: true
end
