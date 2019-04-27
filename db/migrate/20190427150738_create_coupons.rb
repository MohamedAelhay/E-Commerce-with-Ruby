class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code
      t.datetime :expiration_date
      t.integer :usage_number
      t.string :discount_type
      t.integer :discount_amount

      t.timestamps
    end
  end
end
