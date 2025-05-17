class Operation < ApplicationRecord
  belongs_to :user
  belongs_to :matrix,  optional: true
  belongs_to :vector,  class_name: "Vector",
             foreign_key: "vectors_id",
             optional: true

  enum operation_type: {
    determinant:  0,
    dot_product:  1,
    cross_product: 2
  }

  validates :operation_type, presence: true
  validates :result_data,     presence: true

  validate :correct_inputs

  private

  # Проверяем, что для каждого типа операции заданы нужные ссылки
  def correct_inputs
    case operation_type.to_sym
    when :determinant
      errors.add(:matrix, "must be present for determinant") unless matrix
    when :dot_product, :cross_product
      errors.add(:vector, "must be present for #{operation_type}") unless vector
    end
  end
end
