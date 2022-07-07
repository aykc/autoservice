class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end

    add_index :line_items, %i[order_id service_id], unique: true
  end
end
