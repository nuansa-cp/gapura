class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.datetime :created_at, null: false
      t.datetime :claimed_at
      t.string :claimed_by
      t.references :user, foreign_key: true
      t.string :claim_token, null: false, default: ""
      t.string :note, null: false, default: ""
      t.string :receipt, null: false, default: ""
    end
    add_index :tickets, :claim_token, unique: true
  end
end