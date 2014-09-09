class Output
  def messages
    @message ||= []
  end
  
  def puts(message)
    messages << message
    messages << "\n"
  end

  def print(message)
    messages << message
  end
end