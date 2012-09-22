class AnalyticsViewController < UIViewController

  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Analytics", image:nil, tag:2)
    self
  end

end
