module MessagesHelper

  def message_displayable(message)
    message.user.nickname + " le " + message.created_at.to_s + " - " + message.content
  end
end
