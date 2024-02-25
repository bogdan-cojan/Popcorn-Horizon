class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :movie, null: false, foreign_key: true
      t.date :date
      t.string :time
      t.string :seat_number
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
