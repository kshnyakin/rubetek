class CreateCounters < ActiveRecord::Migration[6.0]
  def change
    create_table :counters do |t|
      t.integer :type, null: false
      t.integer :value, null: false
      t.references :flat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
