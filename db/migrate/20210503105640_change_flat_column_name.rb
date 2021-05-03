class ChangeFlatColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :flats, :number, :address
  end
end
