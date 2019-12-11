class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.integer :first_number
      t.integer :second_number
      t.integer :operation
      t.integer :correct_answer
      t.integer :user_answer
      t.integer :score_id

      t.timestamps
    end
  end
end
