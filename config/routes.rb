ActionController::Routing::Routes.draw do |map|
  map.connect '/authentify/:secret', :controller => 'items', :action => :authentify,
              :conditions => { :method => :get }

  map.with_options :controller => 'items' do |items|
    items.connect   '/', :action => :index,
                    :conditions => { :method => :get }
    items.item      "/:key", :action => :show,
                    :conditions => { :method => :get }

    items.new_item  "/new", :action => :new,
                    :conditions => { :method => :get }

    items.edit_item "/:key/edit", :action => :edit,
                    :conditions => { :method => :get }

    items.connect   "/", :action => :create,
                    :conditions => { :method => :post }
    items.connect   "/:key", :action => :update,
                    :conditions => { :method => :put }
    items.connect   "/:key", :action => :delete,
                    :conditions => { :method => :delete }

    items.with_options :controller => 'events' do |events|
      events.edit_event '/:key/event/:id/edit', :action => :edit,
                        :conditions => { :method => :get }

      events.add_event  '/:key/event/add', :action => :create,
                        :conditions => { :method => :post }

      events.connect    '/:key/event/:id', :action => :update,
                        :conditions => { :method => :put }

      events.connect    '/:key/event/:id', :action => :delete,
                        :conditions => { :method => :delete }

      events.with_options :controller => 'bookings' do |bookings|
        bookings.edit_booking '/:key/event/:id/booking/:booking_id/edit',
                            :action => :edit, :conditions => { :method => :get }
        bookings.connect '/:key/event/:id/booking/add', :action => :create,
                         :conditions => { :method => :post }
        bookings.connect '/:key/event/:id/booking/:booking_id',
                         :action => :update, :conditions => { :method => :put }
        bookings.connect '/:key/event/:id/booking/:booking_id',
                         :action => :delete, :conditions => { :method => :delete }
      end
    end
  end

end
