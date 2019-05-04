class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.belongs_to :brand, foreign_key: true
      t.belongs_to :category, foreign_key: true
      t.belongs_to :store, foreign_key: true
      t.string :title
      t.text :description
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
