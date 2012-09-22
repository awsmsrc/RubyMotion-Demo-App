class Tweet
  attr_accessor :id, :text, :screen_name, :retweet_count

  def initialize(options={})
    setValuesForKeysWithDictionary(options)
    self
  end

  def setValue(value, forUndefinedKey:key)
  end
end
