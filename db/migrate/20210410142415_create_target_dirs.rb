class CreateTargetDirs < ActiveRecord::Migration[6.1]
  def change
    create_table :target_dirs do |t|
      t.string :path
      t.string :name

      t.timestamps
    end
  end
end
