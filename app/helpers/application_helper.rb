# 这里作用是当他没有明确标题时我们用这个辅助成标题
module ApplicationHelper

  def full_title(page_title = '')
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    page_title + "|" + base_title
  end
  end
  end

