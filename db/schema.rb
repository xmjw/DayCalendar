# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121029223810) do

  create_table "entries", :force => true do |t|
    t.integer  "week"
    t.integer  "user_id"
    t.integer  "year"
    t.decimal  "hours"
    t.integer  "activity_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "lozenge_entries", :force => true do |t|
    t.integer  "entry_id"
    t.string   "color"
    t.integer  "slot"
    t.integer  "day"
    t.boolean  "lo"
    t.boolean  "ro"
    t.boolean  "bo"
    t.boolean  "to"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
