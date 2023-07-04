class ChangeBelongsToToHasMany < ActiveRecord::Migration[7.0]
  def change
    remove_reference :carts, :book
    add_column :carts, :book_ids, :integer, array: true
  end
end
