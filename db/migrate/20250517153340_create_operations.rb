class CreateOperations < ActiveRecord::Migration[8.0]
  def change
    create_table :operations do |t|
      t.references :user, foreign_key: true, index: true
      t.references :matrix, foreign_key: true, index: true
      t.references :vector, foreign_key: true, index: true
      t.integer    :operation_type, null: false, default: 0, index: true
      t.json :result_data, null: false, default: {}
      t.timestamps
    end
  end
end
