class TopicManager

  def initialize(node)
    @node = node
  end

  def assign_topics(*string_attrs)
    topics(string_attrs).each do |name|
      @node.topics << create_topic(name)
    end
  end

  protected

  def create_topic(name)
    Topic.find_or_create(name: name)
  end

  def topics(*string_attrs)
    all_topics = Set.new()
    [string_attrs].flatten.each do |s|
      all_topics = all_topics + extractor.topics(s)
    end
    all_topics
  end

  def extractor
    @extractor ||= TopicExtractor.new()
  end

end
