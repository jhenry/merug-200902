class AddEventAttendeeData < ActiveRecord::Migration
  def self.up
    add_column :event_attendees, :distance, :string, :null => true
    add_column :event_attendees, :carbon, :string, :null => true
  end

  def self.down
    remove_column :event_attendees, :distance
    remove_column :event_attendees, :carbon
  end
end
