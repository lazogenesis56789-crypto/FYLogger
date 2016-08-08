//
//  FYLog.swift
//  FYLog
//
//  Created by syxc on 16/2/23.
//  Copyright © 2016年 syxc. All rights reserved.
//
//  By using Swift build flags, different log levels can be used in debugging versus staging/production.
//  Go to Build settings -> Swift Compiler - Custom Flags -> Other Swift Flags and add -DDEBUG to the Debug entry.
//
//  Inspired by https://github.com/IBM-Swift/HeliumLogger
//

import Foundation
#if os(iOS)
  import UIKit
#endif

public enum LogLevel: String {
  case Verbose = "VERBOSE"
  case Info    = "INFO"
  case Debug   = "DEBUG"
  case Warn    = "WARN"
  case Error   = "ERROR"
}

public protocol Logger {
  func log(level: LogLevel, msg: String, funcName: String, lineNum: Int, fileName: String)
}

public class FYLog: Logger {
  public var debug: Bool = true
  public var details: Bool = true
  
  public init() {}
  
  public init(debug: Bool, details: Bool) {
    self.debug = debug
    self.details = details
  }
  
  public func log(level: LogLevel, msg: String, funcName: String, lineNum: Int, fileName: String) {
    guard debug else {
      return
    }
    // Debug model
    if details {
      print("\(now()) [\(level.rawValue)] \(funcName) \((fileName as NSString).lastPathComponent) [line:\(lineNum)] --- \(msg)")
    } else {
      print("\(now()) [\(level.rawValue)] \(msg)")
    }
  }
}

extension FYLog {
  /// Verbose
  public func verbose(msg: String, funcName: String = #function,
                      lineNum: Int = #line, fileName: String = #file ) {
    log(.Verbose, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Info
  public func info(msg: String, funcName: String = #function,
                   lineNum: Int = #line, fileName: String = #file) {
    log(.Info, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Debug
  public func debug(msg: String, funcName: String = #function,
                    lineNum: Int = #line, fileName: String = #file) {
    log(.Debug, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Warn
  public func warn(msg: String, funcName: String = #function,
                   lineNum: Int = #line, fileName: String = #file) {
    log(.Warn, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Error
  public func error(msg: String, funcName: String = #function,
                    lineNum: Int = #line, fileName: String = #file) {
    log(.Error, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /* ---------- iOS ---------- */
  
  /// Show log in UIAlertView
  public func alert(message: String, filename: String = #file, function: String = #function, line: Int = #line) {
    guard debug else {
      return
    }
    #if os(iOS)
      let titleString = "\((filename as NSString).lastPathComponent) [line:\(line)]"
      let messageString = "\(now()) \(function) --- \(message)"
      let alertView = UIAlertView(
        title: titleString,
        message: messageString,
        delegate:nil,
        cancelButtonTitle:"OK")
      alertView.show()
    #endif
  }
  
  // MARK: - Helper
  
  /// Get current date
  func now() -> String {
    let date: NSDate = NSDate()
    let fmt: NSDateFormatter = NSDateFormatter()
    fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
    if let now: String = fmt.stringFromDate(date) {
      return now
    }
    return "🙇"
  }
}
