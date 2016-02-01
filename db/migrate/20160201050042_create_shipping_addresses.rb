class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.string :shipping_address

      t.timestamps null: false
    end
  end
end
