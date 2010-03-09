module ApplicationHelper
  def local_time_str(utc_time)
    utc_time.localtime.strftime("%Y-%m-%d %H:%M")
  end
  
  def trunc(s, max=100)
    return s if s.nil? or s.length <= max
    return s[0..(max-4)] + '...'
  end

  def trunc0(s)
    trunc(s, 20)
  end
  
  def n_s(num_str, word)
    "#{num_str.nil? ? 0 : num_str} #{word}#{num_str.to_i > 1 ? 's' : ''}"
  end
  
  def crumb_navbar
    sep = ' > ' #'&raquo;'
    home_types_links = link_to('Home', root_path) + sep + 
        link_to('Types', types_path)
    begin
      case controller_name
      when 'users' then
        return link_to('Home', root_path) + sep + 
          (@user.nil? ? 'Users' : link_to('Users', users_path) + sep + @user.name)

      when 'types' then
        return link_to('Home', root_path) + sep + 
          (@type.nil? ? 'Types' : link_to('Types', types_path) + sep + @type.name)

      when 'subtypes' then
        if @subtype.nil?
          t = @type
          index = true
        else
          t = @subtype.type
          index = false
        end
        return home_types_links + sep + 
          link_to(t.name, type_path(t)) + sep + 
            (index ? 'Subtypes' : link_to('Subtypes', 
            type_subtypes_path(t)) + sep + @subtype.name)

      when 'questions' then
        if @question.nil?
          t = @subtype.type
          st = @subtype
          index = true
        else
          t = @question.type
          st = @question.subtype
          index = false
        end
        return home_types_links + sep + 
          link_to(t.name, type_path(t)) + sep + 
          link_to('Subtypes', type_subtypes_path(t)) + sep +
          link_to(st.name, subtype_path(st)) + sep + 
            (index ? 'Questions' : link_to('Questions', 
            subtype_questions_path(st)) + sep + trunc0(@question.name))

      when 'answers' then
        if @answer.nil?
          q = @question
          index = true
        else    
          q = @answer.question
          index = false
        end
        t = q.type
        st = q.subtype
        return home_types_links + sep + 
          link_to(t.name, type_path(t)) + sep + 
          link_to('Subtypes', type_subtypes_path(t)) + sep +
          link_to(st.name, subtype_path(st)) + sep + 
          link_to('Questions', subtype_questions_path(st)) + sep + 
          link_to(trunc0(q.name), question_path(q)) + sep + 
            (index ? 'Answers' : link_to('Answers', 
            question_answers_path(q)) + sep + trunc0(@answer.name))

      when 'tags' then
        if @tag.nil?
          q = @question
          index = true
        else    
          q = @tag.question
          index = false
        end
        t = q.type
        st = q.subtype
        return home_types_links + sep + 
          link_to(t.name, type_path(t)) + sep + 
          link_to('Subtypes', type_subtypes_path(t)) + sep +
          link_to(st.name, subtype_path(st)) + sep + 
          link_to('Questions', subtype_questions_path(st)) + sep + 
          link_to(trunc0(q.name), question_path(q)) + sep + 
            (index ? 'Tags' : link_to('Tags', question_tags_path(q)) + sep + trunc0(@tag.name))
      else
        return home_types_links
      end
    rescue
      return home_types_links
    end
  end
end
