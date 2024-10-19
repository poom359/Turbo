create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.integer "task_category_id"
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
  