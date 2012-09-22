class Favourites
  LIMIT = 5

  def self.add(id)
  end

  def self.remove(id)
  end

  def return_tweets_with_callback(&block)
    block.call(self) if block
  end
end
