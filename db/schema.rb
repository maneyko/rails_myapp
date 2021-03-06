# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_16_221114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "job_results", force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "status", default: 0
    t.jsonb "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_results_on_job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.text "name", null: false
    t.index ["name"], name: "index_jobs_on_name", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.string "ip_address", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
