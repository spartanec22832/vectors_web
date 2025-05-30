  class Vector < ApplicationRecord
    belongs_to :user
    has_many   :operations, foreign_key: "vector_id", dependent: :nullify

    validates :coords, presence: true
  end
