class QuestionsController < ApplicationController
  # GET /questions  /questions?sort=xxx&order=ASC|DESC
  #     (?sort=xxx may be answers, subtype, updated_at...)
  # GET /questions.xml
  def index
    sort = params[:sort] || 'updated_at'
    order = (params[:order] || 'DESC') + (sort == 'name' ? '' : ', name')
    @type = Type.find_by_id(params[:type_id])
    @subtype = Subtype.find_by_id(params[:subtype_id])
    cond = {}
    cond[:type_id] = @type.id unless @type.nil?
    cond[:subtype_id] = @subtype.id unless @subtype.nil?
    
    case sort
    when 'subtype' then
      @questions = Question.find_by_sql("SELECT questions.*, subtypes.name AS st FROM questions
        LEFT JOIN subtypes ON questions.subtype_id=subtypes.id ORDER BY st " + order, :conditions => cond)
    else
      @questions = Question.all(:order => sort + ' ' + order, :conditions => cond)
      #@questions = Question.paginate :page => params[:page], :per_page => 5
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  # GET /questions/search?TYPE=xxx  (TYPE may be tag/type/subtype/user.)
  # GET /questions/search?TYPE=xxx&sort=yyy&order=ASC|DESC
  def search
    @questions = []
    @title = ''
    begin # TODO: multiple query conditions! zu he & mo hu cha xun!
      sort = params[:sort] || 'updated_at'
      order = params[:order] || 'DESC'
      sort = ' ORDER BY ' + sort + ' ' + order + (sort == 'name' ? '' : ', name')
      if v = params[:tag]
        #tags = Tag.find_by_sql(["SELECT DISTINCT question_id FROM tags WHERE name=?", v])
        #@questions = Question.find(:all, :conditions => 
        #  { :id => tags.map {|t| t.question_id} }, :order => "updated_at DESC")
        @questions = Question.find_by_sql(["SELECT * FROM questions WHERE id IN 
          (SELECT DISTINCT question_id FROM tags WHERE name=?)" + sort, v])
        @title = 'Tag: ' + v
      elsif v = params[:type]
        #type = Type.find_by_name(v)
        #@questions = Question.find_all_by_type_id(type.id, :order => "updated_at DESC")
        @questions = Question.find_by_sql(["SELECT * FROM questions WHERE type_id = 
          (SELECT id FROM types WHERE name=?)" + sort, v])
        @title = 'Type: ' + v
      elsif v = params[:subtype]
        @questions = Question.find_by_sql(["SELECT * FROM questions WHERE subtype_id = 
          (SELECT id FROM subtypes WHERE name=?)" + sort, v])
        @title = 'Subtype: ' + v
      elsif v = params[:user]
        @questions = Question.find_by_sql(["SELECT * FROM questions WHERE user_id = 
          (SELECT id FROM users WHERE name=?)" + sort, v])
        @title = 'User: ' + v
      end
    rescue
    end

    respond_to do |format|
      format.html # search.html.erb
      #format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find_by_id(params[:id])
    if @question.nil?
      return render :text => 'Sorry, not found.'
    end
    @question.view_count += 1
    Question.increment_counter(:view_count, @question.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new
    @question.subtype = Subtype.find_by_id(params[:subtype_id])
    @question.type_id = @question.subtype.type_id unless @question.subtype.nil?
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])

    respond_to do |format|
      if @question.save
        User.increment_counter(:question_count, @question.user_id)
        Type.increment_counter(:question_count, @question.type_id)
        Subtype.increment_counter(:question_count, @question.subtype_id)
        format.html { redirect_to(@question, :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    User.decrement_counter(:question_count, @question.user_id)
    Type.decrement_counter(:question_count, @question.type_id)
    Subtype.decrement_counter(:question_count, @question.subtype_id)

    respond_to do |format|
      format.html { redirect_to(subtype_questions_url(@question.subtype)) }
      format.xml  { head :ok }
    end
  end
end
