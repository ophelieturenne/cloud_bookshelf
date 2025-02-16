class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :photo, :string
    add_column :users, :admin, :boolean, default: false
  end
end
