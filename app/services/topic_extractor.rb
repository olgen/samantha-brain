class TopicExtractor

  TOPICS = %w(
    ruby
    js
    css
    tracking
    fix
   )

  INTERESTING_TOPICS = %w(
    ruby
    js
    css
    tracking
    seo
    acquisition
    referral
  )

  attr_reader :known_topics, :topic_frequencies

  def initialize
    # seed topics with known ones
    @known_topics = Set.new(TOPICS)
    @topic_frequencies = {}
  end

  def topics(subject)
    whitelist_topics = @known_topics.select do |topic|
      subject.match(/#{topic}/i)
    end

    tags = extract_tags(subject)
    all_topics = (whitelist_topics + tags).uniq
    result = all_topics # & INTERESTING_TOPICS
    track_topic_frequencies(result)
    return result
  end

  def track_topic_frequencies(topics)
    topics.each do |topic|
      @topic_frequencies[topic] ||= 0
      @topic_frequencies[topic] += 1
    end
  end

  # Only allow tags starting with an alpha character
  TAG_REGEXP = /#([[:alpha:]][\w]*)/i
  def extract_tags(subject)
    tags = subject.to_s.scan(TAG_REGEXP).flatten
    # add tags to known topics
    remember_topics(tags) if tags.any?
    tags
  end

  def remember_topics(topics)
    topics.each do |topic|
      @known_topics << topic
    end
  end

end
