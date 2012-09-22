class SearchViewController < UIViewController
  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle('Search', image:nil, tag:1)
    self
  end

  def loadView
    self.view = SearchView.alloc.initWithDelegate(self)
  end

  def viewDidLoad
    super
    self.title = 'Search'
    @search_engine = SearchEngine.initWithDelegate(self)
  end

  def search_engine_did_return_tweets(tweets)
    self.view.table.reloadData
  end

  private

  #tableview delegate methods
  def tableView(tableView, cellForRowAtIndexPath:index)
    @reuseIdentifier ||= 'CELL_IDENTIFIER'
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    cell.textLabel.text = @search_engine.tweets[index.row].text
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @search_engine.tweets.nil? ? 0 : @search_engine.tweets.length
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    id = @search_engine.tweets[indexPath.row].id
    app_delegate.router.open("tweets/#{id}", true)    
  end

  #searchbar delegate methods
  def searchBarSearchButtonClicked(searchbar)
    @search_engine.query(searchbar.text)
    searchbar.showsCancelButton = false
    searchbar.resignFirstResponder
  end

  def searchBarCancelButtonClicked(searchbar)
    searchbar.resignFirstResponder
    searchbar.showsCancelButton = false
  end

  def searchBarDidBeginEditing(searchbar)
    searchbar.showsCancelButton = true
  end

  def searchBarShouldBeginEditing(searchbar)
    searchbar.showsCancelButton = true
    true
  end

  def searchBarDidEndEditing(searchbar)
    searchbar.showsCancelButton = false
    searchbar.resignFirstResponder
  end
end
