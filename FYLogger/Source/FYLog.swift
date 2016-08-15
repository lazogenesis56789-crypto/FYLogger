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
  case verbose, debug, info, warn, error
}

extension LogLevel: Comparable {
  var description: String {
    return String(self).uppercased()
  }
}

public func ==(x: LogLevel, y: LogLevel) -> Bool {
  return x.hashValue == y.hashValue
}

public func <(x: LogLevel, y: LogLevel) -> Bool {
  return x.hashValue < y.hashValue
}


public protocol Logger {
  func log(_ level: LogLevel, msg: String, funcName: String, lineNum: Int, fileName: String)
}


public class FYLog: Logger {
  /// The logger state
  public var debug: Bool = true
  
  /// The details
  public var details: Bool = true
  
  /// The minimum level of severity
  public var minLevel: LogLevel = .verbose
  
  public init() {}
  
  /**
   Create and return a new logger.
   
   - parameter debug:    The formatter.
   - parameter details:  The details.
   - parameter minLevel: The minimum level of severity.
   
   - returns: A new logger instance.
   */
  public init(debug: Bool, details: Bool, minLevel: LogLevel = .verbose) {
    self.debug = debug
    self.details = details
    self.minLevel = minLevel
  }
  
  public func log(_ level: LogLevel, msg: String, funcName: String, lineNum: Int, fileName: String) {
    guard debug && level >= minLevel else {
      return
    }
    
    var result = "\(now()) [\(level.description)] \(msg)"
    if details {
      result = "\(now()) [\(level.description)] \(funcName) \(fileName.lastPathComponent) [line:\(lineNum)] --- \(msg)"
    }
    
    DispatchQueue.global().async {
      Swift.print(result)
    }
  }
}

extension FYLog {
  /// Verbose
  public func verbose(_ msg: String, funcName: String = #function, lineNum: Int = #line, fileName: String = #file) {
    log(.verbose, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Debug
  public func debug(_ msg: String, funcName: String = #function, lineNum: Int = #line, fileName: String = #file) {
    log(.debug, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Info
  public func info(_ msg: String, funcName: String = #function, lineNum: Int = #line, fileName: String = #file) {
    log(.info, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Warn
  public func warn(_ msg: String, funcName: String = #function, lineNum: Int = #line, fileName: String = #file) {
    log(.warn, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Error
  public func error(_ msg: String, funcName: String = #function, lineNum: Int = #line, fileName: String = #file) {
    log(.error, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /* ---------- iOS ---------- */
  
  /// Show log in UIAlertView
  public func alert(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {
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
    let date: Date = Date()
    let fmt: DateFormatter = DateFormatter()
    fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
    if let now: String = fmt.string(from: date) {
      return now
    }
    return "🙇"
  }
}

// MARK: - String

internal extension String {
  var lastPathComponent: String {
    return NSString(string: self).lastPathComponent
  }
}
