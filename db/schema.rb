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

ActiveRecord::Schema.define(version: 20171128034559) do

  create_table "assessment_checks", force: :cascade do |t|
    t.integer "entry_id"
    t.string "name"
    t.string "href"
    t.string "system"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cvsses", force: :cascade do |t|
    t.integer "entry_id"
    t.string "score"
    t.string "access_vector"
    t.string "access_complexity"
    t.string "authentication"
    t.string "confidentiality_impact"
    t.string "integrity_impact"
    t.string "availability_impact"
    t.string "source"
    t.string "generated_on_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", force: :cascade do |t|
    t.string "cve"
    t.string "published_datetime"
    t.string "last_modified_datetime"
    t.string "summary"
    t.string "cwe"
    t.string "security_protection"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "references", force: :cascade do |t|
    t.integer "entry_id"
    t.string "source"
    t.string "ref_type"
    t.string "reference"
    t.string "href"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scanners", force: :cascade do |t|
    t.integer "entry_id"
    t.string "name"
    t.string "href"
    t.string "system"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vulnerable_software_lists", force: :cascade do |t|
    t.integer "entry_id"
    t.string "product"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
