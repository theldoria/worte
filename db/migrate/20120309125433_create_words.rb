class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.string :spelling
      t.text :comment
      t.integer :month
      t.boolean :polish
      t.boolean :german

      t.timestamps
    end
  end
end
