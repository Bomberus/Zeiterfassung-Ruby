class CreateTimeTickets < ActiveRecord::Migration
  def change
    create_table :time_tickets do |t|
      t.datetime :arrival
      t.datetime :departure
      t.date :date
      t.boolean :is_finished
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
