class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.date :date
      t.integer :click
      t.integer :view
      t.integer :play
      t.integer :pause
      t.integer :add
      t.integer :remove
      t.integer :download
      t.integer :select
      t.integer :load
      t.integer :scroll

      t.timestamps
    end
  end
end
