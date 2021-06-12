class ChangeDatatypeUserIdOfBooks < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :user_id, :integer
  end
end
