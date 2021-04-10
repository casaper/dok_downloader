class CreateDownloads < ActiveRecord::Migration[6.1]
  def change
    create_table :downloads do |t|
      t.references :target_dir, null: false, foreign_key: true
      t.string :url
      t.datetime :added_at
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
