//
//  MainViewController.swift
//  FYLoggerDemo
//
//  Created by syxc on 16/2/23.
//  Copyright © 2016年 syxc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()    
    logger.info("from \(self.classForCoder)")
    alert("from \(self.classForCoder)")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
