class CreateAuditLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :audit_logs do |t|
      t.references :user, foreign_key: true, index: true
      t.integer    :event_type, null: false, default: 0, index: true
      t.json       :payload,    null: false, default: {}
      t.timestamps
    end
  end
end
