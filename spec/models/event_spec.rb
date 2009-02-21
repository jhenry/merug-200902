require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Event do
  before(:each) do
    @person = people(:aaron)
     @event = Event.new do |event|
       event.title = 'event title'
       event.description = 'event description'
       event.person = @person  
       event.start_time = Time.now
       event.end_time = Time.now
       event.reminder = false
       event.privacy = 1
       event.location = '37.791821,-122.394679'
     end     
  end

  it "should create a new instance given valid attributes" do
      @event.save
  end

  describe "privacy settings" do
    before(:each) do
      @person = people(:aaron)
      @contact = people(:quentin)
    end
    it "should find all public events" do
      Event.person_events(@person).should include(events(:public))
    end

    it "should find contact's events" do
      @person.stub!(:contact_ids).and_return([@contact.id])
      Event.person_events(@person).should include(events(:private))
    end

    it "should find own events" do
      Event.person_events(@contact).should include(events(:private))
    end                   
    
    it 'should not find other private events who are not my friends' do
      Event.person_events(@person).should_not include(events(:private))
    end
                                       
  end

  describe "attendees association" do
    before(:each) do
      @event = events(:public)
      @person = people(:aaron)
    end
    
    it "should allow people to attend" do
      @event.attend(@person)                                   
      @event.attendees.should include(@person)
      @event.reload
      @event.event_attendees_count.should be(1)
    end

    it 'should not allow people to attend twice' do
      @event.attend(@person).should_not be_nil
      @event.attend(@person).should be_nil
    end
                                        
  end

  describe "comments association" do
    before(:each) do
      @event = events(:public)
    end

    it "should have many comments" do
      @event.comments.should be_a_kind_of(Array)
      @event.comments.should_not be_empty
    end
  end

  describe 'event activity association' do
    before(:each) do
      @event.save
      #@event = @valid_event
      @activity = Activity.find_by_item_id(@event)
    end
    
    it "should have an activity" do
      @activity.should_not be_nil
    end
    
    it "should add an activity to the creator" do
      @event.person.recent_activity.should contain(@activity)
    end
  end

end
