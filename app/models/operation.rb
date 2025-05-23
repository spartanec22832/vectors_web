class Operation < ApplicationRecord
  belongs_to :user
  belongs_to :matrix, optional: true
  belongs_to :vector, class_name: "Vector", foreign_key: "vector_id", optional: true

  enum :operation_type, {
    determinant:   0,
    dot_product:   1,
    cross_product: 2
  }
end
