module ApplicationHelper
  def html_safe(*args)
    output = "".html_safe
    args.each {|current_arg|
      output << current_arg.html_safe
    }
    output
  end

  def parse_flash(flash)
    hash = {}

    if flash[:error]
      hash[:message] = flash[:error]
      hash[:style] = 'alert-danger'
    elsif flash[:notice]
      hash[:message] = flash[:notice]
      hash[:style] = 'alert-info'
    elsif flash[:success]
      hash[:message] = flash[:success]
      hash[:style] = 'alert-success'
    end

    return hash
  end

  def display_flash(flash_content)
    flash_msg = "<div id=\"flash_message\" class=\"alert #{flash_content[:style]} alert-dismissible\">"\
      "<button type=\"button\" class=\"close\" data-dismiss=\"alert\">"\
        "<span aria-hidden=\"true\">&times;</span>"\
      "</button>"\
      "#{flash_content[:message]}"\
    "</div>"

    return html_safe(flash_msg)
  end

end
