module RecordsHelper

  def share_link(id1, id2)
    hostname = request.base_url
    link = "#{hostname}/find_id?id1=#{id1}&id2=#{id2}"
    return link
  end


  def go_to_next_page(url, page_num)
    if url.include?("&page=")
      page_index = url.index("page=") + 5
      current_page = url[page_index].to_i
      url.slice!(url[page_index])     # => remove the current page number
      url.slice!("&page=")           # => remove "&page="

      if (current_page+1) > page_num
        current_page = 1
      else
        current_page += 1
      end

      url += ("&page=#{current_page}")

    else
      url += "&page=2"
    end

    return url
    
  end

  def go_to_previous_page(url, page_num)
    if url.include?("&page=")
      page_index = url.index("page=") + 5
      current_page = url[page_index].to_i
      url.slice!(url[page_index])     # => remove the current page number
      url.slice!("&page=")           # => remove "&page="

      if current_page < 1
        current_page = page_num
      else
        current_page -= 1
      end

      url += ("&page=#{current_page}")

    else
        url += ("&page=#{page_num}")
    end

    return url
    
  end

end
