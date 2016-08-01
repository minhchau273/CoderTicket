class RemoveTotalFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :total, :integer
  end
end
