class AddColumnsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :title, :string
    add_column :books, :body, :text
    add_reference :books, :user, null: false, foreign_key: true
  end
end
