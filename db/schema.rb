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

ActiveRecord::Schema[7.0].define(version: 2023_08_09_023631) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "todo_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "assign_id", null: false
    t.string "title", null: false
    t.text "content"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_todo_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.text "jti", null: false
    t.text "reset_jti"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "birthday"
    t.string "cellphone", null: false
    t.string "phone"
    t.string "school", null: false
    t.string "main_grade"
    t.string "sub_grade"
    t.string "county"
    t.string "address"
    t.string "branch_school"
    t.boolean "enabled", default: false
  end

  add_foreign_key "todo_lists", "users"
end
