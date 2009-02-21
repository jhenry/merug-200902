class AddEventLocation < ActiveRecord::Migration
  def self.up
    add_column :events, :location, :string, :null => true
  end

  def self.down
    remove_column :events, :location
  end
end
