class CreateGuitars < ActiveRecord::Migration
  def self.up
    create_table :guitars do |t|
      t.integer :person_id
      t.string :title
      t.text :specs
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :guitars
  end
end
