class EventsController < ApplicationController
  # GET /:key/event/:id/edit
  def edit
  end

  # POST /:key/event/add
  def create
    @item = Item.find_by_key(params[:key])

    dates = params[:event].delete(:dates)
    e = Event.new(params[:event].merge(:item => @item))
    if e.valid?
      dates = extract_dates(dates)
      p dates

    else
      flash[:errors] = ""
      e.errors.each do |attr,msg|
        flash[:errors] += "<li>#{msg}</li>"
      end
      redirect_to item_path(:key => @item.key)
    end
  end

  # PUT /:key/event/:id
  def update
  end

  # DELETE /:key/event/:id
  def delete
  end

  private
    def extract_dates(text)
      text.each_line.to_a
    end
end
