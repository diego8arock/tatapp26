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

ActiveRecord::Schema.define(version: 2018_12_05_035634) do

  create_table "assignments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384", force: :cascade do |t|
    t.integer "id_project_employee", null: false
    t.integer "id_seat", null: false
    t.date "assignment_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", limit: 1, null: false
    t.index ["id_project_employee"], name: "FK_assignment_project_employee"
    t.index ["id_seat"], name: "FK_assignment_seat"
  end

  create_table "employees", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384", force: :cascade do |t|
    t.string "name", null: false
    t.string "number", limit: 30, null: false
    t.date "admission_date", null: false
    t.date "birthdate", null: false
    t.integer "status", limit: 1, default: 1, null: false
    t.integer "assignment_type", limit: 1, default: 1, null: false, comment: "Fijo:1 o movil:2"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "id_seat"
    t.index ["id_seat"], name: "FK_employees_seats_id"
    t.index ["number"], name: "id_number", unique: true
  end

  create_table "maps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "seats"
    t.integer "height"
    t.integer "width"
    t.integer "seats_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id", null: false
    t.index ["project_id"], name: "fk_maps_projects_idx"
  end

  create_table "project_employees", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192", force: :cascade do |t|
    t.integer "id_project", null: false
    t.integer "id_employee", null: false
    t.integer "status", limit: 1, null: false
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.index ["id_employee"], name: "FK_project_employee_employee"
    t.index ["id_project"], name: "FK_project_employee_project"
  end

  create_table "projects", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", limit: 1, default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at"
    t.string "tag", limit: 3, null: false
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "seats", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192", force: :cascade do |t|
    t.integer "id_project", null: false
    t.string "code", limit: 10, null: false
    t.integer "status", limit: 1, default: 1, null: false
    t.date "assignment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at"
    t.bigint "id_map", null: false
    t.index ["code"], name: "number", unique: true
    t.index ["id_map"], name: "fk_seats_maps_idx"
    t.index ["id_project"], name: "FK_seat_project"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "employee_number"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["employee_number"], name: "index_users_on_employee_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "users_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "assignments", "project_employees", column: "id_project_employee", name: "FK_assignment_project_employee"
  add_foreign_key "assignments", "seats", column: "id_seat", name: "FK_assignment_seat"
  add_foreign_key "employees", "seats", column: "id_seat", name: "FK_employees_seats_id"
  add_foreign_key "maps", "projects", name: "fk_maps_projects"
  add_foreign_key "project_employees", "employees", column: "id_employee", name: "FK_project_employee_employee"
  add_foreign_key "project_employees", "projects", column: "id_project", name: "FK_project_employee_project"
  add_foreign_key "seats", "maps", column: "id_map", name: "fk_seats_maps"
  add_foreign_key "seats", "projects", column: "id_project", name: "FK_seat_project"
end
