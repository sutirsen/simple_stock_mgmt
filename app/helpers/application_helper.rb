module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Sample Stock Management"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def title_match(title, matcher)
    if matcher.kind_of?(Array)
      matcher.each do |mt|
        if /#{mt}/.match(title)
          return true
        end
      end
      return false
    else
      if /#{matcher}/.match(title)
        return true
      end
      return false
    end
  end
end
