class CreateTableCart < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.belongs_to :user
      t.belongs_to :book
      t.timestamps
    end
  end
end
