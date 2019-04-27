class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.text :summary

      t.timestamps
    end
  end
end
