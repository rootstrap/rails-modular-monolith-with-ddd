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

ActiveRecord::Schema[7.0].define(version: 2023_04_10_001354) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transactional_outbox_outboxes", force: :cascade do |t|
    t.string "aggregate", null: false
    t.string "aggregate_identifier", null: false
    t.string "event", null: false
    t.uuid "identifier", null: false
    t.jsonb "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_transactional_outbox_outboxes_on_identifier"
  end

  create_table "user_access_consumed_messages", force: :cascade do |t|
    t.uuid "event_id"
    t.string "aggregate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["event_id", "aggregate"], name: "index_user_access_consumed_messages_on_event_id_and_aggregate", unique: true
    t.index ["status"], name: "index_user_access_consumed_messages_on_status"
  end

  create_table "user_access_outboxes", force: :cascade do |t|
    t.uuid "identifier", null: false
    t.string "event", null: false
    t.jsonb "payload"
    t.string "aggregate", null: false
    t.uuid "aggregate_identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aggregate_identifier"], name: "index_user_access_outboxes_on_aggregate_identifier"
    t.index ["identifier"], name: "index_user_access_outboxes_on_identifier", unique: true
  end

  create_table "user_access_permissions", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_user_access_permissions_on_code"
  end

  create_table "user_access_role_to_permissions", force: :cascade do |t|
    t.integer "role_code", null: false
    t.string "permission_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_code"], name: "index_user_access_role_to_permissions_on_permission_code"
    t.index ["role_code"], name: "index_user_access_role_to_permissions_on_role_code"
  end

  create_table "user_access_user_registrations", force: :cascade do |t|
    t.string "login", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "name", null: false
    t.integer "status_code", null: false
    t.datetime "registered_at", precision: nil, null: false
    t.datetime "confirmed_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.uuid "identifier", null: false
    t.index ["identifier"], name: "index_user_access_user_registrations_on_identifier", unique: true
  end

  create_table "user_access_user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "role_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_code"], name: "index_user_access_user_roles_on_role_code"
    t.index ["user_id"], name: "index_user_access_user_roles_on_user_id"
  end

  create_table "user_access_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "login", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "name", null: false
    t.uuid "identifier", null: false
    t.integer "status_code", default: 0
    t.index ["email"], name: "index_user_access_users_on_email", unique: true
    t.index ["identifier"], name: "index_user_access_users_on_identifier", unique: true
    t.index ["reset_password_token"], name: "index_user_access_users_on_reset_password_token", unique: true
  end

end
