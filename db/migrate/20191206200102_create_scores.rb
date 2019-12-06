class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.integer :total_score
      t.string :question_types
      t.integer :response_times
      t.integer :setting_id

      t.timestamps
    end
  end
end
