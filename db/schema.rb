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

ActiveRecord::Schema.define(version: 2020_08_02_175941) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zipcode"
    t.float "latitude"
    t.float "longitude"
    t.boolean "default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_profile_id"
    t.index ["user_profile_id"], name: "index_addresses_on_user_profile_id"
  end

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "carts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "total", precision: 6, scale: 2
    t.json "items"
    t.boolean "locked", default: false
    t.integer "sub_id_increment", default: 1
    t.integer "current_address_id"
    t.bigint "user_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_profile_id"], name: "index_carts_on_user_profile_id"
  end

  create_table "checkouts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "status", default: "waiting_confirmation"
    t.json "payment_method"
    t.bigint "cart_id"
    t.bigint "user_profile_id"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_checkouts_on_address_id"
    t.index ["cart_id"], name: "index_checkouts_on_cart_id"
    t.index ["user_profile_id"], name: "index_checkouts_on_user_profile_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "status", default: "done"
    t.json "payment_method"
    t.json "items"
    t.bigint "user_profile_id"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["user_profile_id"], name: "index_orders_on_user_profile_id"
  end

  create_table "payment_pagarmes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "payment_type", default: ""
    t.string "payment_type2", default: ""
    t.string "payment_type3", default: ""
    t.string "name", default: ""
    t.string "description", default: ""
    t.string "sub_description", default: ""
    t.string "sub_description2", default: ""
    t.string "card_id", default: ""
    t.string "brand", default: ""
    t.string "holder_name", default: ""
    t.string "payment_observation", default: ""
    t.string "observation", default: ""
    t.boolean "default", default: false
    t.bigint "payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_payment_pagarmes_on_payment_id"
  end

  create_table "payment_physicals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "payment_type", default: ""
    t.string "payment_type2", default: ""
    t.string "payment_type3", default: ""
    t.string "name", default: ""
    t.string "description", default: ""
    t.string "payment_observation", default: ""
    t.string "observation", default: ""
    t.boolean "default", default: false
    t.bigint "payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_payment_physicals_on_payment_id"
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_profile_id"], name: "index_payments_on_user_profile_id"
  end

  create_table "product_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_complements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "price", precision: 4, scale: 2
    t.boolean "checked"
    t.bigint "product_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_product_id"], name: "index_product_complements_on_product_product_id"
  end

  create_table "product_ingredients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "price", precision: 4, scale: 2
    t.boolean "checked"
    t.bigint "product_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_product_id"], name: "index_product_ingredients_on_product_product_id"
  end

  create_table "product_products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "price", precision: 4, scale: 2
    t.integer "min_complements"
    t.integer "max_complements"
    t.integer "max_ingredients"
    t.integer "min_variations"
    t.integer "max_variations"
    t.bigint "product_category_id"
    t.bigint "product_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_category_id"], name: "index_product_products_on_product_category_id"
    t.index ["product_type_id"], name: "index_product_products_on_product_type_id"
  end

  create_table "product_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_variations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "price", precision: 4, scale: 2
    t.boolean "checked"
    t.bigint "product_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_product_id"], name: "index_product_variations_on_product_product_id"
  end

  create_table "user_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "genre"
    t.date "birth_date"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider", default: "telephone", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "name"
    t.string "telephone"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_profile_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["telephone"], name: "index_users_on_telephone", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["user_profile_id"], name: "index_users_on_user_profile_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "user_profiles"
  add_foreign_key "carts", "user_profiles"
  add_foreign_key "checkouts", "addresses"
  add_foreign_key "checkouts", "carts"
  add_foreign_key "checkouts", "user_profiles"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "user_profiles"
  add_foreign_key "payment_pagarmes", "payments"
  add_foreign_key "payment_physicals", "payments"
  add_foreign_key "payments", "user_profiles"
  add_foreign_key "product_complements", "product_products"
  add_foreign_key "product_ingredients", "product_products"
  add_foreign_key "product_products", "product_categories"
  add_foreign_key "product_products", "product_types"
  add_foreign_key "product_variations", "product_products"
  add_foreign_key "users", "user_profiles"
end
