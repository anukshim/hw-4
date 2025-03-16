class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.string "title"
      t.text "description"
      t.date "occurred_on"
      t.integer "place_id"
      t.integer "user_id"

      t.timestamps
    end
  end
end
