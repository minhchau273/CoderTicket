class AddRemainToTicketTypes < ActiveRecord::Migration
  def change
    add_column :ticket_types, :remain, :integer
  end
end
