class CreatePublishers < ActiveRecord::Migration[8.0]
  def change
    create_table :publishers do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :publishers, :name, unique: true
    add_index :publishers, :active
  end
end
