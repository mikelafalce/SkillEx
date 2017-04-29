class AddAvatarToSkills < ActiveRecord::Migration[5.1]
  def change
    add_column :skills, :avatar, :string
  end
end
