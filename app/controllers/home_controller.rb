class HomeController < ApplicationController
  def index
    @rows_limit = 5
    @latest_questions = Question.all(:order => "updated_at DESC", :limit => @rows_limit)
    @latest_answers = Answer.all(:order => "updated_at DESC", :limit => @rows_limit)

    @hot_tags = Tag.find_by_sql("SELECT COUNT(*) AS count, id, name FROM tags 
      GROUP BY name ORDER BY COUNT(*) DESC, name LIMIT #{@rows_limit}")
    @hot_questions = Question.all(:order => "answer_count DESC, name", :limit => @rows_limit)
    @hot_questions_of_views = Question.all(:order => "view_count DESC, name", :limit => @rows_limit)
    @hot_answers_of_views = Answer.all(:order => "view_count DESC, updated_at DESC", :limit => @rows_limit)
    @hot_subtypes = Subtype.all(:order => "question_count DESC, name", :limit => @rows_limit)
    @hot_types = Type.all(:order => "question_count DESC, name", :limit => @rows_limit)
    @hot_users_of_questions = User.all(:order => "question_count DESC, name", :limit => @rows_limit)
    @hot_users_of_answers = User.all(:order => "answer_count DESC, name", :limit => @rows_limit)
  end
    
=begin
    # Old SQLs:
    #@hot_questions = Question.find_by_sql("SELECT * FROM questions WHERE id IN 
    #  (SELECT question_id FROM answers GROUP BY question_id 
    #  ORDER BY COUNT(*) DESC, name LIMIT #{@rows_limit})")
    @hot_questions = Question.find_by_sql(
      "SELECT questions.*, answer_count FROM questions LEFT JOIN
      (SELECT question_id, COUNT(*) AS answer_count FROM answers GROUP BY question_id 
      ORDER BY COUNT(*) DESC, question_id LIMIT #{@rows_limit}) 
      ON questions.id=question_id ORDER BY answer_count DESC LIMIT #{@rows_limit}")

    @hot_subtypes = Subtype.find_by_sql(
      "SELECT subtypes.*, question_count FROM subtypes LEFT JOIN
      (SELECT subtype_id, COUNT(*) AS question_count FROM questions GROUP BY subtype_id 
      ORDER BY COUNT(*) DESC, subtype_id LIMIT #{@rows_limit}) 
      ON subtypes.id=subtype_id ORDER BY question_count DESC LIMIT #{@rows_limit}")

    @hot_types = Type.find_by_sql(
      "SELECT types.*, question_count FROM types LEFT JOIN
      (SELECT type_id, COUNT(*) AS question_count FROM questions GROUP BY type_id 
      ORDER BY COUNT(*) DESC, type_id LIMIT #{@rows_limit}) 
      ON types.id=type_id ORDER BY question_count DESC LIMIT #{@rows_limit}")

    @hot_users_of_questions = User.find_by_sql(
      "SELECT users.*, question_count FROM users LEFT JOIN
      (SELECT user_id, COUNT(*) AS question_count FROM questions GROUP BY user_id 
      ORDER BY COUNT(*) DESC, user_id LIMIT #{@rows_limit}) 
      ON users.id=user_id ORDER BY question_count DESC LIMIT #{@rows_limit}")

    @hot_users_of_answers = User.find_by_sql(
      "SELECT users.*, answer_count FROM users LEFT JOIN
      (SELECT user_id, COUNT(*) AS answer_count FROM answers GROUP BY user_id 
      ORDER BY COUNT(*) DESC, user_id LIMIT #{@rows_limit}) 
      ON users.id=user_id ORDER BY answer_count DESC LIMIT #{@rows_limit}")
=end

end
