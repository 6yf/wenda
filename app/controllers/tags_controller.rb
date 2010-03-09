class TagsController < ApplicationController
  # GET /tags
  # GET /tags.xml
  def index
    sort = params[:sort] || 'question_count'
    order = (params[:order] || 'DESC') + (sort == 'name' ? '' : ', name')
    @question = Question.find_by_id(params[:question_id])
    cond = @question.nil? ? {} : {:question_id => @question}
    
    case sort
    when 'question_count' then
      @tags = Tag.find_by_sql("SELECT *, COUNT(*) AS count FROM tags
        GROUP BY name ORDER BY COUNT(*) " + order)
    else
      @questions = Question.all(:order => sort + ' ' + order, :conditions => cond)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  def show
    @tag = Tag.find_by_id(params[:id])
    if @tag.nil?
      return render :text => 'Sorry, not found.'
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.xml
  def new
    @tag = Tag.new
    @tag.question_id = params[:question_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to(@tag, :notice => 'Tag was successfully created.') }
        format.xml  { render :xml => @tag, :status => :created, :location => @tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to(@tag, :notice => 'Tag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(question_tags_url(@tag.question)) }
      format.xml  { head :ok }
    end
  end
end
