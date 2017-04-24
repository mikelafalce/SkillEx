class CreateSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :skills do |t|

      t.references :teacher

      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
