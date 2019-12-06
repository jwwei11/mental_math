class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.integer :owner_id
      t.integer :upper_digit_limit
      t.integer :lower_digit_limit
      t.boolean :multiplication
      t.boolean :addition
      t.boolean :division
      t.boolean :subtraction

      t.timestamps
    end
  end
end
