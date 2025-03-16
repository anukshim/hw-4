class AddUserIdToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :user_id, :integer
  end
end
