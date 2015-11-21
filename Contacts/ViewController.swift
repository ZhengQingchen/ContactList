//
//  ViewController.swift
//  Contacts
//
//  Created by mac on 15/11/21.
//  Copyright © 2015年 mac. All rights reserved.
//

import UIKit
import Fakery

struct Person {
  var name: String?
  var phone: String?
  var color: UIColor?
  init(){
    
  }
}


let arrayPrefix = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","#"]

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var searchController: UISearchController!
  var people: [Person] = []
  var newPeople:[(String, [Person])]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getFakerDate()
    
    let resultViewController = storyboard?.instantiateViewControllerWithIdentifier("SearchResult") as! SearchResultViewController
    resultViewController.searchModel = people
    searchController = UISearchController(searchResultsController: resultViewController)
    
    searchController.searchResultsUpdater = resultViewController
    tableView.tableHeaderView = searchController.searchBar
  }
  
  func getFakerDate(){
    let faker = Faker(locale: "nb-NO")
    var morePeople: [String: [Person]] = [:]
    for _ in 0...100 {
      var person = Person()
      person.name = faker.name.name()
      person.phone = faker.phoneNumber.phoneNumber()
      person.color = UIColor.randomColor()
      people.append(person)
    }
    // Do any additional setup after loading the view, typically from a nib.
    
    people.sortInPlace{
      $0.name < $1.name
    }
    
    for item in people {
      for prefix in arrayPrefix {
        if item.name!.hasPrefix(prefix) {
          if var innerPerson = morePeople[prefix] {
            innerPerson.append(item)
            morePeople.updateValue(innerPerson, forKey: prefix)
          }else {
            var new = [Person]()
            new.append(item)
            morePeople.updateValue(new, forKey: prefix)
          }
        }
      }
    }
    
    let newarray =  morePeople.sort { (item1, item2) -> Bool in
      item1.0 < item2.0
    }
    
    newPeople = newarray
  }
}
extension ViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return newPeople.count
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return newPeople[section].1.count
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
    cell.imageView?.image = imageOfSize(CGSize(width: 40, height: 40)){ () -> () in
      let con = UIGraphicsGetCurrentContext()!
      CGContextAddEllipseInRect(con, CGRectMake(0,0,40,40))
      CGContextSetFillColorWithColor(con, UIColor.randomColor().CGColor)
      CGContextFillPath(con)
    }
    cell.imageView?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    
    let userSection = newPeople[indexPath.section]
    let user = userSection.1[indexPath.row]
    
    cell.textLabel?.text = user.name
    cell.detailTextLabel?.text = user.phone
    return cell
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return newPeople[section].0
  }
  
  func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//      var stringArray = [String]()
//      for item in newPeople {
//        stringArray.append(item.0)
//      }
//      return stringArray
        return arrayPrefix
  }
}


func imageOfSize(size: CGSize, _ opaque: Bool = false, @noescape _ closuer:() -> ()) -> UIImage {
  UIGraphicsBeginImageContextWithOptions(size, opaque, 0)
  closuer()
  let result = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()
  return result
}

