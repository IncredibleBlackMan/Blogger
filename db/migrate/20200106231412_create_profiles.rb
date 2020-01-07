# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.text :bio
      t.string :avatar
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
