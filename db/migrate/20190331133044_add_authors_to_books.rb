class AddAuthorsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :authors, :text
  end
end
