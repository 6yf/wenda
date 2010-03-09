class SubtypesController < ApplicationController
  # GET /subtypes
  # GET /subtypes.xml
  def index
    sort = params[:sort] || 'question_count'
    order = params[:order] || 'DESC'
    order = sort + ' ' + order + (sort == 'name' ? '' : ', name')
    @type = Type.find_by_id(params[:type_id])
    cond = @type.nil? ? {} : {:type_id => @type}
    @subtypes = Subtype.all(:order => order, :conditions => cond)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subtypes }
    end
  end

  # GET /subtypes/1
  # GET /subtypes/1.xml
  def show
    @subtype = Subtype.find_by_id(params[:id])
    if @subtype.nil?
      return render :text => 'Sorry, not found.'
    end
    @questions = @subtype.questions.all(:order => "updated_at DESC")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subtype }
    end
  end

  # GET /subtypes/new
  # GET /subtypes/new.xml
  def new
    @subtype = Subtype.new
    @subtype.type_id = params[:type_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subtype }
    end
  end

  # GET /subtypes/1/edit
  def edit
    @subtype = Subtype.find(params[:id])
  end

  # POST /subtypes
  # POST /subtypes.xml
  def create
    @subtype = Subtype.new(params[:subtype])

    respond_to do |format|
      if @subtype.save
        format.html { redirect_to(@subtype, :notice => 'Subtype was successfully created.') }
        format.xml  { render :xml => @subtype, :status => :created, :location => @subtype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subtypes/1
  # PUT /subtypes/1.xml
  def update
    @subtype = Subtype.find(params[:id])

    respond_to do |format|
      if @subtype.update_attributes(params[:subtype])
        format.html { redirect_to(@subtype, :notice => 'Subtype was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subtypes/1
  # DELETE /subtypes/1.xml
  def destroy
    @subtype = Subtype.find(params[:id])
    @subtype.destroy

    respond_to do |format|
      format.html { redirect_to(type_subtypes_path(@subtype.type)) }
      format.xml  { head :ok }
    end
  end
end
