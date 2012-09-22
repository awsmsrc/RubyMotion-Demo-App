class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    puts "On Load: #{App::Persistence['tweets']}"
    initialize_view_controllers
    create_window
    true
  end

  def router
    return @router if @router
    @router = Routable::Router.router
    @router.navigation_controller = UINavigationController.alloc.init
    @router.map('search', SearchViewController)
    @router.map('tweets/:id', TweetViewController)
    @router
  end
  
  private

  def initialize_view_controllers
    @search_controller = SearchViewController.new
    @analytics_controller = AnalyticsViewController.new
    @tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
    @tab_controller.viewControllers = [router.navigation_controller, @analytics_controller]
    router.open('search', false)
  end

  def create_window
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = @tab_controller
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
  end
end
