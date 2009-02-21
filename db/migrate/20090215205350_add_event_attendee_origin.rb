class AddEventAttendeeOrigin < ActiveRecord::Migration
  def self.up
    add_column :event_attendees, :origin, :string, :null => true
  end

  def self.down
    remove_column :event_attendees, :origin
  end
end
