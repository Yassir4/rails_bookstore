class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.belongs_to :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
