# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_22_194243) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "audit_logs", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "event_type", default: 0, null: false
    t.json "payload", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_type"], name: "index_audit_logs_on_event_type"
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "matrices", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.json "matrix_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_matrices_on_user_id"
  end

  create_table "operations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "matrix_id"
    t.bigint "vector_id"
    t.integer "operation_type", default: 0, null: false
    t.json "result_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matrix_id"], name: "index_operations_on_matrix_id"
    t.index ["operation_type"], name: "index_operations_on_operation_type"
    t.index ["user_id"], name: "index_operations_on_user_id"
    t.index ["vector_id"], name: "index_operations_on_vector_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.string "email", limit: 255, null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  create_table "vectors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.json "coords", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vectors_on_user_id"
  end

  add_foreign_key "audit_logs", "users"
  add_foreign_key "operations", "matrices"
  add_foreign_key "operations", "users"
  add_foreign_key "operations", "vectors"
end
