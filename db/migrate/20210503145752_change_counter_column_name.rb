class ChangeCounterColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :counters, :type, :water_type
  end
end
