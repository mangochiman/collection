class CreateBookCollections < ActiveRecord::Migration
  def self.up
    create_table :book_collections do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :book_collections
  end
end
