class GuitarsController < ApplicationController
  include GuitarsHelper

  before_filter :login_required
  before_filter :correct_user_required, :only => [ :edit, :update, :destroy ]

  # GET /guitars
  # GET /guitars.xml
  def index
    @body = "guitars"
    @person = Person.find(params[:person_id])
    @guitars = @person.guitars.paginate :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @guitars }
    end
  end

  # GET /guitars/1
  # GET /guitars/1.xml
  def show
    @body = "guitar"
    @guitar = Guitar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @guitar }
    end
  end

  # GET /guitars/new
  # GET /guitars/new.xml
  def new
#    @guitar = Guitar.new
    @guitar = current_person.guitars.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @guitar }
    end
  end

  # GET /guitars/1/edit
  def edit
    @guitar = Guitar.find(params[:id])
  end

  # POST /guitars
  # POST /guitars.xml
  def create
    @guitar = current_person.guitars.build(params[:guitar])

    respond_to do |format|
      if @guitar.save
        flash[:notice] = 'Guitar was successfully created.'
        format.html { redirect_to guitar_path(@guitar) }
        format.xml  { render :xml => @guitar, :status => :created, :location => @guitar }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @guitar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /guitars/1
  # PUT /guitars/1.xml
  def update
    @guitar = Guitar.find(params[:id])

    respond_to do |format|
      if @guitar.update_attributes(params[:guitar])
        flash[:notice] = 'Guitar was successfully updated.'
        format.html { redirect_to guitar_path(@guitar) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @guitar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /guitars/1
  # DELETE /guitars/1.xml
  def destroy
    @guitar = Guitar.find(params[:id])
    @guitar.destroy

    respond_to do |format|
      format.html { redirect_to person_guitars_path(current_person) }
      format.xml  { head :ok }
    end
  end


  def justcomments
    @guitar = Guitar.find(params[:id] )
    respond_to do |format|
      format.html { render :partial => 'comments/comment', :collection => @guitar.comments }
      format.xml  { head :ok }
      format.js
    end
  end


  private
    def correct_user_required
      @guitar = Guitar.find(params[:id])
      if @guitar.nil?
        flash[:error] = "No guitar found"
        redirect_to person_guitars_path(current_person)
      elsif @guitar.person != current_person
        flash[:error] = "You are not the owner of this guitar"
        redirect_to person_guitars_path(@guitar.person)
      end
    end


end
