class ChangeHasManyToBelongsTo < ActiveRecord::Migration[7.0]
  def change
    remove_column :carts, :book_ids
    add_reference :carts, :book
  end
end
