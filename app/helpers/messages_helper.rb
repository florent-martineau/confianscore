module MessagesHelper

  def message_displayable(message)
    content_tag(:div, content_tag(:div, message.user.nickname + " a dit, le " + message.created_at.to_s + " : ") + content_tag(:div, message.content))
  end
end
