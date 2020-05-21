class CreateChores < ActiveRecord::Migration[5.2]
  def change
    create_table :chores do |t|
      t.references :child, foreign_key: true
      t.references :task, foreign_key: true
      t.date :due_on
      t.boolean :completed

      t.timestamps
    end
  end
end
