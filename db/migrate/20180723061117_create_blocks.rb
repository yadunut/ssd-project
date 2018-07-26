# frozen_string_literal: true

class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.references :user
      t.references :blocked

      t.timestamps
    end
  end
end
