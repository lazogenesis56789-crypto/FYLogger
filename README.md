# FYLogger
A tiny logging framework for iOS, Inspired by [HeliumLogger](https://github.com/IBM-Swift/HeliumLogger).

### Features

- Different logging levels such as Warning, Verbose, and Error
- Support Show logging in `UIAlertView`
- Debug, Release model

### Example Usage

```swift
import FYLogger

let log = FYLog()

log.info("from \(self.classForCoder)")
log.alert("from \(self.classForCoder)")
```

Debug, Release model
> By using Swift build flags, different log levels can be used in debugging versus staging/production.
> Go to Build settings -> Swift Compiler - Custom Flags -> Other Swift Flags and add `-DDEBUG` to the Debug entry.

```swift
/// Setup FYLogger
func setupLogger() {
  #if DEBUG
    log.debug = true
  #else
    log.debug = false
  #endif
}
```

## License

FYLogger is available under the MIT license. See the [LICENSE](https://github.com/syxc/FYLogger/blob/master/LICENSE) file for more info.






