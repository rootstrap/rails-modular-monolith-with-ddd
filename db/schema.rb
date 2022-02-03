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

ActiveRecord::Schema.define(version: 2022_01_25_232600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_access_user_registrations", force: :cascade do |t|
    t.string "login", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "name", null: false
    t.integer "status_code", null: false
    t.datetime "registered_at", null: false
    t.datetime "confirmed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_access_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "login", null: false
    t.boolean "is_active", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "name", null: false
    t.index ["email"], name: "index_user_access_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_access_users_on_reset_password_token", unique: true
  end

end
