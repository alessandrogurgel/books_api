class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.string :isbn
      t.string :country
      t.integer :number_of_pages
      t.string :publisher
      t.date :release_date

      t.timestamps
    end
    add_index :books, :name
    add_index :books, :country
    add_index :books, :publisher
    add_index :books, :release_date
  end
end
