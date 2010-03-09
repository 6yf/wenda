module QuestionsHelper
  def page_title
    title = "#{@questions.count} Questions for "
    title += 'All Types ' if @type.nil? && @subtype.nil?
    title += "Type [#{@type.name}] " unless @type.nil?
    title += "Subtype [#{@subtype.name}] " unless @subtype.nil?
    return title
  end
end
