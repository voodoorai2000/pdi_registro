class OrchardsController < ApplicationController
  # GET /orchards
  # GET /orchards.xml
  def index
    @orchards = Orchard.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orchards }
    end
  end

  # GET /orchards/1
  # GET /orchards/1.xml
  def show
    @orchard = Orchard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orchard }
    end
  end

  # GET /orchards/new
  # GET /orchards/new.xml
  def new
    @orchard = Orchard.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orchard }
    end
  end

  # GET /orchards/1/edit
  def edit
    @orchard = Orchard.find(params[:id])
  end

  # POST /orchards
  # POST /orchards.xml
  def create
    @orchard = Orchard.new(params[:orchard])

    respond_to do |format|
      if @orchard.save
        flash[:notice] = 'Orchard was successfully created.'
        format.html { redirect_to(@orchard) }
        format.xml  { render :xml => @orchard, :status => :created, :location => @orchard }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orchard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orchards/1
  # PUT /orchards/1.xml
  def update
    @orchard = Orchard.find(params[:id])

    respond_to do |format|
      if @orchard.update_attributes(params[:orchard])
        flash[:notice] = 'Orchard was successfully updated.'
        format.html { redirect_to(@orchard) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orchard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orchards/1
  # DELETE /orchards/1.xml
  def destroy
    @orchard = Orchard.find(params[:id])
    @orchard.destroy

    respond_to do |format|
      format.html { redirect_to(orchards_url) }
      format.xml  { head :ok }
    end
  end
end
