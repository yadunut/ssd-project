# frozen_string_literal: true

class AddUniqueIndexToBlock < ActiveRecord::Migration[5.2]
  def change
    add_index :blocks, %i[user_id blocked_id], unique: true
  end
end
