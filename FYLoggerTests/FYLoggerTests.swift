//
//  FYLoggerTests.swift
//  FYLoggerTests
//
//  Created by syxc on 16/2/24.
//  Copyright © 2016年 syxc. All rights reserved.
//

import XCTest
@testable import FYLogger

let log = FYLog()

class FYLoggerTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testSimpleGuardText() {
    assert(simpleGuardText == "123", "simpleGuardText value is '123'")
  }
  
  func testSimpleIfText() {
    assert(simpleIfText == "abc", "simpleGuardText value is 'abc'")
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock {
      // Put the code you want to measure the time of here.
    }
  }
  
  var simpleGuardText: String {
    guard log.debug else {
      return "abc"
    }
    return "123"
  }
  
  var simpleIfText: String {
    if log.debug {
      return "abc"
    }
    return "123"
  }
}
