class ItemsController < ApplicationController
  before_filter :set_date

  # GET /
  def index
    render :action => 'public_index' unless session[:authorized]

    @items = Item.find(:all, :include => [:events])
  end

  # GET /:key
  def show
    @item = Item.find_by_key(params[:key])
  end

  # GET /new
  def new
  end

  # GET /:key/edit
  def edit
    render :action => 'public_edit' unless session[:authorized]
  end

  # POST /
  def create
  end

  # PUT /:key
  def update
  end

  # DELETE /:key
  def delete
  end

  # GET /authentify
  def authentify
    if params[:secret] == ADMIN_SECRET_KEY
      session[:authorized] = true
    end
    redirect_to '/'
  end

  private
    def set_date
      @date = begin
        Date.strptime(params[:date], '%d/%m/%Y')
      rescue ArgumentError, TypeError
        Date.today
      end
    end
end
