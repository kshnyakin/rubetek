class CreateFlats < ActiveRecord::Migration[6.0]
  def change
    create_table :flats do |t|
      t.integer :number
      t.text :comment

      t.timestamps
    end
  end
end
