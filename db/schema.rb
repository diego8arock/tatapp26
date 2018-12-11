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

ActiveRecord::Schema.define(version: 2018_12_07_010454) do

  create_table "assignments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "employee_id", null: false
    t.bigint "seat_id", null: false
    t.date "assignment_date", null: false
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "fk_rails_d0980e430f"
    t.index ["project_id"], name: "fk_rails_4d3d2c839c"
    t.index ["seat_id"], name: "fk_rails_1eb99de2cc"
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "number", limit: 30, null: false
    t.date "admission_date", null: false
    t.date "birth_date", null: false
    t.integer "status", default: 1, null: false
    t.integer "assignment_type", default: 1, null: false
    t.bigint "seat_id"
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_employees_on_number", unique: true
    t.index ["project_id"], name: "fk_rails_f3055ce412"
    t.index ["seat_id"], name: "fk_rails_c961385dd5"
  end

  create_table "maps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "seats"
    t.integer "height", null: false
    t.integer "width", null: false
    t.integer "seats_total", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "fk_rails_a90d6cd6e2"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", default: 1, null: false
    t.string "tag", limit: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "seats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "code", limit: 10, null: false
    t.integer "status", default: 1, null: false
    t.date "assignment_date"
    t.bigint "map_id", null: false
    t.string "html_id", null: false
    t.boolean "fixed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "fk_rails_f35d21dd46"
    t.index ["project_id"], name: "fk_rails_93e3b7506d"
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

  add_foreign_key "assignments", "employees"
  add_foreign_key "assignments", "projects"
  add_foreign_key "assignments", "seats"
  add_foreign_key "employees", "projects"
  add_foreign_key "employees", "seats"
  add_foreign_key "maps", "projects"
  add_foreign_key "seats", "maps"
  add_foreign_key "seats", "projects"
end
