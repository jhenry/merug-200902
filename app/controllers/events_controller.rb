class EventsController < ApplicationController

  before_filter :login_required
  before_filter :load_event, :except => [:index, :new, :create]
  before_filter :load_date, :only => [:index, :show]
  before_filter :authorize_show, :only => :show
  before_filter :authorize_change, :only => [:edit, :update]
  before_filter :authorize_destroy, :only => :destroy
  
  protect_from_forgery :only => [:create, :update, :destroy] 
  
  def index
    @month_events = Event.monthly_events(@date).person_events(current_person)
    unless filter_by_day?
      @events = @month_events
    else
      @events = Event.daily_events(@date).person_events(current_person)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  def show
    load_map(@event.location)
    @month_events = Event.monthly_events(@date).person_events(current_person)
    @attendees = @event.attendees.paginate(:page => params[:page], 
                                           :per_page => RASTER_PER_PAGE)
    @carbon = 0
    @distance = 0
    @event.attendees.each { |e| 
      @carbon += e.carbon.to_f 
      @distance += e.distance.to_f
      }
                                           
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  def new
    @event = Event.new
    
    load_map()
        
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  def edit
    load_map(@event.location)  
  end

  def create
    @event = Event.new do |event|
      event.title = params[:event][:title]
      event.description = params[:event][:description]
      event.person = current_person  
      event.start_time = params[:event][:start_time]
      event.end_time = params[:event][:end_time]
      event.reminder = params[:event][:reminder]
      event.privacy = params[:event][:privacy]
      event.location = params[:event][:location]  
    end
            
    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to(@event) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        load_map(@event.location)
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
      if params[:event]
      @event.title = params[:event][:title]
      @event.description = params[:event][:description]
      @event.person = current_person  
      @event.start_time = params[:event][:start_time]
      @event.end_time = params[:event][:end_time]
      @event.reminder = params[:event][:reminder]
      @event.privacy = params[:event][:privacy]
      @event.location = params[:event][:location]  
    end
    
    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
      else
        load_map(@event.location)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end

  def attend
    # calculate carbon, my multiplying meters by the 
    event_attendee_distance = params["event_attendee_distance"]
    
    event_attendee_carbon = (event_attendee_distance.to_i / 1000) * 0.2700
    if @event.attend(current_person, params["event_attendee_origin"], event_attendee_distance, event_attendee_carbon)
      flash[:notice] = "You are attending this event."
      redirect_to @event
    else
      flash[:error] = "You can only attend once."
      redirect_to @event
    end
  end

  def unattend
    if @event.unattend(current_person)
      flash[:notice] = "You are not attending this event."
      redirect_to @event
    else
      flash[:error] = "You are not attending this event."
      redirect_to @event
    end
  end

  private
    
    def in_progress
      flash[:notice] = "Work on this feature is in progress."
      redirect_to home_url
    end
  
    def authorize_show
      if (@event.only_contacts? and
          not (@event.person.contact_ids.include?(current_person.id) or
               current_person?(@event.person) or current_person.admin?))
        redirect_to home_url 
      end
    end
  
    def authorize_change
      redirect_to home_url unless current_person?(@event.person)
    end

    def authorize_destroy
      can_destroy = current_person?(@event.person) || current_person.admin?
      redirect_to home_url unless can_destroy
    end

    def load_date
      if @event
        @date = @event.start_time
      else
        now = Time.now
        year = (params[:year] || now.year).to_i
        month = (params[:month] || now.month).to_i
        day = (params[:day] || now.mday).to_i
        @date = DateTime.new(year,month,day)
      end
    rescue ArgumentError
      @date = Time.now
    end

    def filter_by_day?
      !params[:day].nil?
    end

    def load_event
      @event = Event.find(params[:id])
    end
    
    def load_map(location="2 Free St, Portland, ME 04101")      
      location ||= "2 Free St, Portland, ME 04101" 
      
      @map = GMap.new("map_div")
      @map.control_init(:small_map => true,:map_type => true)
      results = Geocoding::get(location)
      if results.status == Geocoding::GEO_SUCCESS
        coord = results[0].latlon
        @map.center_zoom_init(coord,15)
        @map.overlay_init(GMarker.new(coord))
      end
    end

end
