class ChangeTypeFlatColumnAddress < ActiveRecord::Migration[6.0]
  def change
    change_column :flats, :address, :string
  end
end
