class AnswersController < ApplicationController
  # GET /answers
  # GET /answers.xml
  def index
    sort = params[:sort] || 'updated_at'
    order = (params[:order] || 'DESC') + (sort == 'name' ? '' : ', name')
    @question = Question.find_by_id(params[:question_id])
    cond = {}
    cond[:question_id] = @question.id unless @question.nil?
    @answers = Answer.all(:order => sort + ' ' + order, :conditions => cond)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answers }
    end
  end

  # GET /answers/search?TYPE=XYZ  (TYPE may be user.)
  def search
    @answers = []
    @title = ''
    begin
    if v = params[:user]
      @answers = Answer.find_by_sql(["SELECT * FROM answers WHERE user_id = 
        (SELECT id FROM users WHERE name=?) ORDER BY updated_at DESC", v])
      @title = 'User: ' + v
    end
    rescue
    end

    respond_to do |format|
      format.html # search.html.erb
      #format.xml  { render :xml => @question }
    end
  end

  # GET /answers/1
  # GET /answers/1.xml
  def show
    @answer = Answer.find_by_id(params[:id])
    if @answer.nil?
      return render :text => 'Sorry, not found.'
    end
    @answer.view_count += 1
    Answer.increment_counter(:view_count, @answer.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.xml
  def new
    @answer = Answer.new
    @answer.question_id = params[:question_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # POST /answers
  # POST /answers.xml
  def create
    @answer = Answer.new(params[:answer])

    respond_to do |format|
      if @answer.save
        Question.increment_counter(:answer_count, @answer.question_id)
        User.increment_counter(:answer_count, @answer.user_id)
        format.html { redirect_to(@answer, :notice => 'Answer was successfully created.') }
        format.xml  { render :xml => @answer, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.xml
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to(@answer, :notice => 'Answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    Question.decrement_counter(:answer_count, @answer.question_id)
    User.decrement_counter(:answer_count, @answer.user_id)

    respond_to do |format|
      format.html { redirect_to(question_answers_url(@answer.question)) }
      format.xml  { head :ok }
    end
  end
end
