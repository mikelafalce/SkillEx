class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|

      t.references :skill
      t.references :teacher
      t.references :student

      t.integer :teacher_rating_student
      t.integer :student_rating_teacher
      
      t.datetime :start_time
      t.integer :hours
      t.datetime :requested_at
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
