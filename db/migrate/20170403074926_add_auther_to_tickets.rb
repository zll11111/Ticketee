class AddAutherToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :auther, index: true
    add_foreign_key :tickets,:users,column: :auther_id
  end
end
