class AddEmailUniquenessIndex < ActiveRecord::Migration
  def change
    # add_index(table_name, column_name, options = {}) 
    add_index :users, :email, :unique => true
  end
end
