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

ActiveRecord::Schema[7.0].define(version: 2023_04_10_011139) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meetings_consumed_messages", force: :cascade do |t|
    t.uuid "event_id"
    t.string "aggregate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["event_id", "aggregate"], name: "index_meetings_consumed_messages_on_event_id_and_aggregate", unique: true
    t.index ["status"], name: "index_meetings_consumed_messages_on_status"
  end

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
    t.uuid "identifier", null: false
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

  create_table "meetings_outboxes", force: :cascade do |t|
    t.uuid "identifier", null: false
    t.string "event", null: false
    t.jsonb "payload"
    t.string "aggregate", null: false
    t.uuid "aggregate_identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aggregate_identifier"], name: "index_meetings_outboxes_on_aggregate_identifier"
    t.index ["identifier"], name: "index_meetings_outboxes_on_identifier", unique: true
  end

  add_foreign_key "meetings_meeting_group_proposals", "meetings_members", column: "proposal_user_id"
  add_foreign_key "meetings_meeting_groups", "meetings_meeting_group_proposals", column: "meeting_group_proposal_id"
  add_foreign_key "meetings_meeting_groups", "meetings_members", column: "creator_id"
end
