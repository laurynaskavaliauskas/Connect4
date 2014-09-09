class Output
  def messages
    @message ||= []
  end
  
  def puts(message)
    messages << message
  end
end