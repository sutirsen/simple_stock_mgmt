module ApplicationHelper
  def full_title(page_title = '')
    base_title = ""
    if page_title.empty?
      base_title
    else
      if base_title.empty?
        page_title
      else 
        page_title + " | " + base_title
      end
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

  def cart_size 
    if cookies[:cart] != nil
      return cookies[:cart].split("|").size
    end
    return 0
  end
end
