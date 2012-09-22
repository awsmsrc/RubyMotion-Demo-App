class SearchEngine

  attr_accessor :delegate, :data

  def self.initWithDelegate(delegate)
    this = self.new
    this.delegate = delegate
    this
  end

  def query(query)
     BW::HTTP.get("https://search.twitter.com/search.json?q=#{query}&rpp=25&include_entities=true&result_type=mixed") do |response|
    # BW::HTTP.get("http://localhost/search_twitter.json") do |response|
      self.data = BW::JSON.parse(response.body.to_str)
      delegate.search_engine_did_return_tweets(tweets)
    end
  end

  def get_tweet(id)
    BW::HTTP.get("https://api.twitter.com/1/statuses/show.json?id=#{id}&include_entities=true") do |response|
    # BW::HTTP.get("http://localhost/show_tweet.json") do |response|
      delegate.search_engine_did_return_tweet(Tweet.new(BW::JSON.parse(response.body.to_str)))
    end
  end

  def tweets
    [].tap do |a|
      results.each do |result|
        a << Tweet.new(result)
      end
    end
  end

  def data
    @data ||= {}
  end

  def results
    data[:results] || {}
  end

  private

  def new
    super
  end

end
