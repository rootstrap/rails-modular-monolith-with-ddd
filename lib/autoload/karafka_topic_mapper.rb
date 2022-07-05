class KarafkaTopicMapper
  def initialize(prefix)
    @prefix = prefix
  end

  def incoming(topic)
    topic.to_s.gsub("#{@prefix}.", '')
  end

  def outgoing(topic)
    "#{@prefix}.#{topic}"
  end
end