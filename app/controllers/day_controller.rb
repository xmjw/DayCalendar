class DayController < ApplicationController
  def index
    @week = params[:week]
    @week = Date.today.cweek if @week == nil
  end

  #AJAX Action for creating a new lozenge in the calendar.
  def new
    week = params[:week]
    
    #This isn't quite right... because we shoud be using some sort of unique on this.
    entry = Entry.find_by_week week
    
    @model = calculate_slots params[:s], params[:e]

    @model.each_pair do |k,v|
      LozengeEntry.create({:entry_id => entry.id, 
                           :color    => "#4fff51", 
                           :slot     => k, 
                           :day      => k, 
                           :lo       => v.include?("lo"), 
                           :ro       => v.include?("ro"), 
                           :bo       => v.include?("bo"), 
                           :to       => v.include?("to")})
    end

    current = session[:current]
    
    @pops = {}
    @kill = []
    current.each_pair do |k,v|
      if @model.key? k
        #We have to handle the collision...
        puts k+" - is an overlap. Something must be done."
        @pops = @pops.merge calculate_css_removal current, k, v
        @kill << k
      end
    end

    session[:current] = current.merge @model

    respond_to do |format|
      format.js
    end
  end


  def calculate_css_removal lozengeSet, key, css
    # v tells us what to change,
    # k tells us which siblings to seek.
    # current is the set of things we can check against.

    removeCss = {}

    #get the time numeral
    hourIndex = (/[\d]+/.match key)[0].to_i

    #get the day...
    dayIndex = DayHelper::DayIndex[(/[a-z]+/.match key).to_s]

    if css.include? "lo"
      #Remove 'ro' from element to the left
      removeCss[DayHelper::DayNames[dayIndex-1].downcase+hourIndex.to_s] = "ro"
    end
    if css.include? "ro"
      #Remove 'lo' from element to the right
      index = dayIndex+1
      index = 0 if index == 7
      removeCss[DayHelper::DayNames[index].downcase+hourIndex.to_s] = "lo"
    end
    if css.include? "to"
      #Remove 'bo' from element above
      removeCss[DayHelper::DayNames[dayIndex].downcase+(hourIndex-1).to_s] = "bo"
    end
    if css.include? "bo"
      #Remove 'to' from element below
      removeCss[DayHelper::DayNames[dayIndex].downcase+(hourIndex+1).to_s] = "to"
    end
    removeCss
  end

  def calculate_slots start, finish
     # id format is <day><n> where en = 0.5hours*n+7hours.
     # probably need to make that better.

     #get the time numeral
     sc = (/[\d]+/.match start)[0].to_i
     fc = (/[\d]+/.match finish)[0].to_i

     #get the day...
     sd = DayHelper::DayIndex[(/[a-z]+/.match start).to_s]
     fd = DayHelper::DayIndex[(/[a-z]+/.match finish).to_s]

     components = {}

     lsd = sd
     until lsd > fd
       lsc = sc
       until lsc > fc
         div =  DayHelper::DayNames[lsd].downcase+lsc.to_s
         components[div] = find_css_class sd, fd, sc, fc, lsd, lsc
         lsc+=1
       end
       lsd+=1
     end
     components
  end

  #Works out what classes should be applied
  def find_css_class left, right, top, bottom, currentX, currentY
    css = ""
    css += "lo " if currentX > left
    css += "ro " if currentX < right
    css += "to " if currentY > top
    css += "bo " if currentY < bottom
    css.strip
  end

end
