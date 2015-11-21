//
//  Helper.swift
//  Contacts
//
//  Created by mac on 15/11/21.
//  Copyright © 2015年 mac. All rights reserved.
//

import UIKit


extension UIColor{
  class func randomColor() -> UIColor {
    let hue = CGFloat(arc4random() % 100) / 100
    let saturation = CGFloat(arc4random() % 100) / 100
    let brightness = CGFloat(arc4random() % 100) / 100
    
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
  }
}

func afterDelay(seconds:Double,closure:() ->()){
  let when = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
  dispatch_after(when, dispatch_get_main_queue(), closure)
}

infix operator =~ {}
func =~(string:String, regex:String) -> Bool {
  return string.rangeOfString(regex, options: .RegularExpressionSearch) != nil
}