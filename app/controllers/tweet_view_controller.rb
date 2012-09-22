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
    @button.setTitle("Add To Favouries", forState:UIControlStateNormal)
    @button.addTarget(self, action: :add_or_remove_from_favourites, forControlEvents:UIControlEventTouchUpInside)
  end

  def search_engine_did_return_tweet(tweet)
    @label = UILabel.alloc.initWithFrame [[20,20],[280,344]]
    @label.text = tweet.text
    @label.numberOfLines = 0
    @label.sizeToFit
    frame = @label.frame;
    frame.size.width += 20;  
    frame.size.height += 10;  
    @label.frame = frame;
    self.view.addSubview @label
    self.view.addSubview @button
  end

  def add_or_remove_from_favourites
    tweets = App::Persistence['tweets']
    if tweets.nil?
      puts "first tweet"
      tweets = [@id]
    elsif !tweets.include? @id
      puts "add tweet"
      tweets = tweets + [@id]
    else
      puts "remove tweet"
      tweets = tweets - [@id]
    end
    App::Persistence['tweets'] = tweets
    puts "current: #{App::Persistence['tweets']}"
  end

end
