class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :coupon, foreign_key: true
      t.string :state
      t.datetime :order_date
      t.datetime :confirmation_date
      t.datetime :deliverable_date
      t.string :address
      t.float :total_price
      t.float :total_price_after_discount

      t.timestamps
    end
  end
end
