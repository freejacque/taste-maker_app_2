class AddRoleColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: :customer
  end
end
