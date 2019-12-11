class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :results, :score_id, :setting_id
  end
end
