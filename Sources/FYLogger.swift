//
//  FYLogger.swift
//  FYLogger
//
//  Created by syxc on 16/2/23.
//  Copyright © 2016年 syxc. All rights reserved.
//

import Foundation

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

public class FYLogger: Logger {
  public var debug: Bool = true
  public var details: Bool = true
  
  init() {}
  
  init(debug: Bool, details: Bool) {
    self.debug = debug
    self.details = details
  }
  
  public func log(level: LogLevel, msg: String, funcName: String, lineNum: Int, fileName: String) {
    guard debug else {
      /* Release model */
      return
    }
    
    /* Debug model */
    if details {
      print("[\(level.rawValue)] \(funcName) \((fileName as NSString).lastPathComponent) [line:\(lineNum)] --- \(msg)")
    } else {
      print("[\(level.rawValue)] \(msg)")
    }
  }
}

extension FYLogger {
  /// Verbose
  public func verbose(msg: String, funcName: String = __FUNCTION__,
    lineNum: Int = __LINE__, fileName: String = __FILE__ ) {
      log(.Verbose, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Info
  public func info(msg: String, funcName: String = __FUNCTION__,
    lineNum: Int = __LINE__, fileName: String = __FILE__) {
      log(.Info, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Debug
  public func debug(msg: String, funcName: String = __FUNCTION__,
    lineNum: Int = __LINE__, fileName: String = __FILE__) {
      log(.Debug, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Warn
  public func warn(msg: String, funcName: String = __FUNCTION__,
    lineNum: Int = __LINE__, fileName: String = __FILE__) {
      log(.Warn, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
  
  /// Error
  public func error(msg: String, funcName: String = __FUNCTION__,
    lineNum: Int = __LINE__, fileName: String = __FILE__) {
      log(.Error, msg: msg, funcName: funcName, lineNum: lineNum, fileName: fileName)
  }
}


/* ---------- iOS ---------- */

/* By using Swift build flags, different log levels can be used in debugging versus staging/production. Go to Build settings -> Swift Compiler - Custom Flags -> Other Swift Flags and add -DDEBUG to the Debug entry. */

#if DEBUG
  import UIKit
  
  /// Show logger in UIAlertView
  func alertLog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
    let alertView = UIAlertView(
      title: "\((filename as NSString).lastPathComponent) [line:\(line)]",
      message: "\(function) --- \(message)",
      delegate:nil,
      cancelButtonTitle:"OK")
    alertView.show()
  }
#else
  func alertLog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {}
#endif

