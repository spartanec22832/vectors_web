class CreateMatrices < ActiveRecord::Migration[8.0]
  def change
    create_table :matrices do |t|
      t.references :user, null: false, index: true
      t.json :matrix_data, null: false, default: {}
      t.timestamps
    end
  end
end
