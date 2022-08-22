class RemoveUniqueConstraintFromUsersOnRole < ActiveRecord::Migration[7.0]
  def up
    remove_index :users, :role
    add_index :users, :role
  end
  
  def down
    remove_index :users, :role
    add_index :users, :role, unique: true
  end
end
