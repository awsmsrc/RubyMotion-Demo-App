class SearchView < UIView
  attr_accessor :table

  def initWithDelegate(delegate)
    this =  self.initWithFrame([[0,0],[320,366]]) 
    @search_bar = UISearchBar.alloc.initWithFrame([[0,0],[320, 44]])
    @search_bar.placeholder = "Search..."
    @table = UITableView.alloc.initWithFrame([[0,44],[320, 322]])
    @search_bar.delegate = delegate
    @table.dataSource = delegate
    @table.delegate = delegate
    this.addSubview @table
    this.addSubview @search_bar
    this
  end
end
