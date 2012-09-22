class TweetViewController < UIViewController

  def initWithParams(params = {})
    @id = params[:id]
    @search_engine = SearchEngine.initWithDelegate(self)
    @search_engine.get_tweet(@id)
    self
  end

  def viewDidLoad
    super
    self.title = "Display Tweet"
    self.view.backgroundColor = UIColor.underPageBackgroundColor
    @button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @button.setFrame([[30,200],[200,50]])
    unless App::Persistence['tweets'].include? @id
      @button.setTitle("Add To Favouries", forState:UIControlStateNormal)
    else
      @button.setTitle("Remove From Favouries", forState:UIControlStateNormal)
    end
    @button.addTarget(self, action: :add_or_remove_from_favourites, forControlEvents:UIControlEventTouchUpInside)
  end

  def search_engine_did_return_tweet(tweet)
    @label = UILabel.alloc.initWithFrame [[20,20],[280,344]]
    @label.text = tweet.text
    @label.numberOfLines = 0
    @label.sizeToFit
    self.view.addSubview @label
    self.view.addSubview @button
  end

  def add_or_remove_from_favourites
    tweets = App::Persistence['tweets']
    if tweets.nil?
      tweets = [@id]
      @button.setTitle("Remove from Favouries", forState:UIControlStateNormal)
    elsif !tweets.include? @id
      tweets = tweets + [@id]
      @button.setTitle("Remove from Favouries", forState:UIControlStateNormal)
    else
      tweets = tweets - [@id]
      @button.setTitle("Add To Favouries", forState:UIControlStateNormal)
    end
    App::Persistence['tweets'] = tweets
  end

end
