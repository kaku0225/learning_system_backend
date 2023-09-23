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

ActiveRecord::Schema[7.0].define(version: 2023_09_23_082805) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administration_staff_profiles", force: :cascade do |t|
    t.integer "administration_staff_id"
    t.string "gender"
    t.string "cellphone"
    t.string "school"
    t.string "major"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "branch_school_relations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "branch_school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_school_id"], name: "index_branch_school_relations_on_branch_school_id"
    t.index ["user_id"], name: "index_branch_school_relations_on_user_id"
  end

  create_table "branch_schools", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "address"
    t.boolean "enabled", default: false
    t.string "code"
  end

  create_table "class_adviser_profiles", force: :cascade do |t|
    t.integer "class_adviser_id"
    t.string "cellphone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_profiles", force: :cascade do |t|
    t.integer "student_id"
    t.string "birthday"
    t.string "cellphone", null: false
    t.string "phone"
    t.string "school", null: false
    t.string "main_grade"
    t.string "sub_grade"
    t.string "county"
    t.string "address"
    t.string "branch_school"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_profiles", force: :cascade do |t|
    t.integer "teacher_id"
    t.string "gender"
    t.string "cellphone"
    t.string "school"
    t.string "major"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_subjects", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "todo_lists", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.integer "assign_id", null: false
    t.string "title", null: false
    t.text "content"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_todo_lists_on_student_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.text "jti", null: false
    t.text "reset_jti"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enabled", default: false
    t.string "type", null: false
  end

  add_foreign_key "branch_school_relations", "branch_schools"
  add_foreign_key "branch_school_relations", "users"
  add_foreign_key "todo_lists", "users", column: "student_id"
end
