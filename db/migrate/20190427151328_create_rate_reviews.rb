class CreateRateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :rate_reviews do |t|
      t.belongs_to :product, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.integer :rate
      t.text :review

      t.timestamps
    end
  end
end
