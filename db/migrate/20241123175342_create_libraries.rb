class CreateLibraries < ActiveRecord::Migration[7.1]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :unique_id

      t.timestamps
    end
    add_index :libraries, :unique_id
  end
end
