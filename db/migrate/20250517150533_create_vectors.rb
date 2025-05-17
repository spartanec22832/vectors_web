class CreateVectors < ActiveRecord::Migration[8.0]
  def change
    create_table :vectors do |t|
      t.references :user, null: false, index: true
      t.json :coords, null: false, default: {}
      t.timestamps
    end
  end
end
