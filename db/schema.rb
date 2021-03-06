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

ActiveRecord::Schema[7.0].define(version: 2022_04_28_195201) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meetings_meeting_group_proposals", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "location_city", null: false
    t.string "location_country_code", null: false
    t.datetime "proposal_date", precision: nil, null: false
    t.integer "status_code", null: false
    t.bigint "proposal_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proposal_user_id"], name: "index_meetings_meeting_group_proposals_on_proposal_user_id"
  end

  create_table "meetings_meeting_groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "location_city", null: false
    t.string "location_country_code", null: false
    t.bigint "creator_id", null: false
    t.bigint "meeting_group_proposal_id", null: false
    t.date "payment_date_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_meetings_meeting_groups_on_creator_id"
    t.index ["meeting_group_proposal_id"], name: "index_meetings_meeting_groups_on_meeting_group_proposal_id"
  end

  create_table "meetings_members", force: :cascade do |t|
    t.string "login", null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "name", null: false
    t.uuid "identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_meetings_members_on_identifier", unique: true
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
    t.boolean "is_active", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "name", null: false
    t.uuid "identifier", null: false
    t.index ["email"], name: "index_user_access_users_on_email", unique: true
    t.index ["identifier"], name: "index_user_access_users_on_identifier", unique: true
    t.index ["reset_password_token"], name: "index_user_access_users_on_reset_password_token", unique: true
  end

  add_foreign_key "meetings_meeting_group_proposals", "meetings_members", column: "proposal_user_id"
  add_foreign_key "meetings_meeting_groups", "meetings_meeting_group_proposals", column: "meeting_group_proposal_id"
  add_foreign_key "meetings_meeting_groups", "meetings_members", column: "creator_id"
end
