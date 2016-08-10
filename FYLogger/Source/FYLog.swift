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

public enum LogLevel {
  case Verbose, Debug, Info, Warn, Error
}

extension LogLevel: Comparable {
  var description: String {
    return String(self).uppercaseString
  }
}

public func ==(x: LogLevel, y: LogLevel) -> Bool {
  return x.hashValue == y.hashValue
}

public func <(x: LogLevel, y: LogLevel) -> Bool {
  return x.hashValue < y.hashValue
}


public protocol Logger {
  func log(level: LogLevel, msg: String, funcName: String, lineNum: Int, fileName: String)
}


public class FYLog: Logger {
  /// The logger state
  public var debug: Bool = true
  
  /// The details
  public var details: Bool = true
  
  /// The minimum level of severity
  public var minLevel: LogLevel = .Verbose
  
  public init() {}
  
  /**
   Create and return a new logger.
   
   - parameter debug:    The formatter.
   - parameter details:  The details.
   - parameter minLevel: The minimum level of severity.
   
   - returns: A new logger instance.
   */
  public init(debug: Bool, details: Bool, minLevel: LogLevel = .Verbose) {
    self.debug = debug
    self.details = details
    self.minLevel = minLevel
  }
  
  public func log(level: LogLevel, msg: String, funcName: String, lineNum: Int, fileName: String) {
    guard debug && level >= minLevel else {
      return
    }
    
    var result = "\(now()) [\(level.description)] \(msg)"
    if details {
      result = "\(now()) [\(level.description)] \(funcName) \(fileName.lastPathComponent) [line:\(lineNum)] --- \(msg)"
    }
    
    dispatch_async(dispatch_queue_create("FYLogger", DISPATCH_QUEUE_SERIAL)) {
      Swift.print(result)
    }
  }
}

extension FYLog {
  /// Verbose
  public func verbose(msg: String, funcName: String = #function, lineNum: Int = #line, fileName: String = #file) {
    log(.Verbose, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Debug
  public func debug(msg: String, funcName: String = #function, lineNum: Int = #line, fileName: String = #file) {
    log(.Debug, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Info
  public func info(msg: String, funcName: String = #function, lineNum: Int = #line, fileName: String = #file) {
    log(.Info, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Warn
  public func warn(msg: String, funcName: String = #function, lineNum: Int = #line, fileName: String = #file) {
    log(.Warn, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Error
  public func error(msg: String, funcName: String = #function, lineNum: Int = #line, fileName: String = #file) {
    log(.Error, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /* ---------- iOS ---------- */
  
  /// Show log in UIAlertView
  public func alert(message: String, filename: String = #file, function: String = #function, line: Int = #line) {
    guard debug else {
      return
    }
    #if os(iOS)
      let titleString = "\(filename.lastPathComponent) [line:\(line)]"
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
  private func now() -> String {
    let date: NSDate = NSDate()
    let fmt: NSDateFormatter = NSDateFormatter()
    fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
    if let now: String = fmt.stringFromDate(date) {
      return now
    }
    return "🙇"
  }
}

// MARK: - String

private extension String {
  var lastPathComponent: String {
    return (self as NSString).lastPathComponent
  }
}
