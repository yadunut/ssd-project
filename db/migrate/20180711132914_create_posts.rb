class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :body
      t.belongs_to :user, index: true
      t.string :image
      t.integer :visibility

      t.timestamps
    end

    create_table :comments do |t|
      t.string :body
      t.belongs_to :user, index: true
      t.belongs_to :post, index: true
      t.timestamps
    end
  end
end
