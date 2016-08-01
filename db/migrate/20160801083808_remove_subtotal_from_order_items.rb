class RemoveSubtotalFromOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :subtotal, :integer
  end
end
