class AppDelegate

  attr_accessor :router

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    puts "On Load: #{App::Persistence['tweets']}"
    map_urls
    initialize_view_controllers
    create_window
    true
  end
  
  private

  def map_urls
    @router = Routable::Router.router
    @router.navigation_controller = UINavigationController.alloc.init
    @router.map("search", SearchViewController)
    @router.map("tweets/:id", TweetViewController)
  end

  def initialize_view_controllers
    @search_controller = SearchViewController.new
    @analytics_controller = AnalyticsViewController.new
    @tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
    @tab_controller.viewControllers = [@router.navigation_controller, @analytics_controller]
    @router.open('search', false)
  end

  def create_window
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = @tab_controller
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
  end

end
