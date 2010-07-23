class EventsController < ApplicationController
  # GET /:key/event/:id/edit
  def edit
  end

  # POST /:key/event/add
  def create
    @item = Item.find_by_key(params[:key])

    dates = params[:event].delete(:dates)
    event = Event.new(params[:event].merge(:item => @item))
    flash[:errors]  = ""
    flash[:title]   = params[:event][:title]
    flash[:details] = params[:event][:details]
    flash[:dates] = dates

    if event.valid?
      event.save
      parsed_dates = extract_dates(dates)
      if parsed_dates.all? {|d| d.first == :success }
        bookings = []
        parsed_dates.map do |d|
          bookings << Booking.new(:start_at => d[1], :end_at => d[2], :event => event)
        end
        if bookings.all?(&:valid?)
          bookings.each do |b|
            b.event = event
            b.save
          end
        else
          bookings.each do |b|
            b.errors.each do |_,msg|
              flash[:errors] += "<li>#{msg}</li>"
            end
          end
        end

      else
        parsed_dates.select {|d| d.first == :error}.each do |err|
          flash[:errors] += "<li>La date à la ligne #{err.last+1} est invalide</li>"
        end
      end

    else
      e.errors.each do |attr,msg|
        flash[:errors] += "<li>#{msg}</li>"
      end
    end

    redirect_to item_path(:key => @item.key)
  end

  # PUT /:key/event/:id
  def update
  end

  # DELETE /:key/event/:id
  def delete
  end

  private
    def extract_dates(text)
      results = []
      text.each_line.to_a.map(&:chomp).each_with_index do |line,lineno|
        if line =~ /^(\d{2})\/(\d{2})\/(\d{4}) (\d{2}):(\d{2}) (\d{2}):(\d{2})/
          day = "%s-%s-%s" % [$~[3], $~[2], $~[1]]
          begin
            start_at = ("#{day} %s:%s:00" % [$~[4], $~[5]]).to_datetime
            end_at   = ("#{day} %s:%s:00" % [$~[6], $~[7]]).to_datetime
          rescue ArgumentError
            results << [:error, lineno]
            next
          end

          results << [:success, start_at, end_at]
        else
          results << [:error, lineno]
        end
      end
      results
    end
end
