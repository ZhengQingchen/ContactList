//
//  SearchResultViewController.swift
//  Contacts
//
//  Created by mac on 15/11/21.
//  Copyright © 2015年 mac. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  var searchModel: [Person]!
  var searchResultModel: [Person] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return searchResultModel.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ResultCell", forIndexPath: indexPath)
    
    cell.imageView?.image = imageOfSize(CGSize(width: 40, height: 40)){ () -> () in
      let con = UIGraphicsGetCurrentContext()!
      CGContextAddEllipseInRect(con, CGRectMake(0,0,40,40))
      CGContextSetFillColorWithColor(con, UIColor.randomColor().CGColor)
      CGContextFillPath(con)
    }
    cell.imageView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    
    let user = searchResultModel[indexPath.row]
    
    cell.textLabel?.text = user.name
    cell.detailTextLabel?.text = user.phone
    return cell
  }
  
}

extension SearchResultViewController: UISearchResultsUpdating {
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    let searchText = searchController.searchBar.text
    
    searchResultModel =  searchModel.filter { (item) -> Bool in
      item.name! =~ searchText!
    }
  }
}