import Kitura
import SwiftyJSON
import LoggerAPI
import HeliumLogger

#if os(Linux)
    import SwiftGlibc

    public func arc4random_uniform(_ max: UInt32) -> Int32 {
        return (SwiftGlibc.rand() % Int32(max-1)) + 1
    }
#else
    import Darwin
#endif

// Enable warnings
Log.logger = HeliumLogger(.warning)

let router = Router()

// Simple plaintext response with an expensive debug level log message
// Logging level is checked before making the call to avoid String construction
router.get("/plaintext") {
request, response, next in
    response.headers["Content-Type"] = "text/plain"
    response.status(.OK).send("Hello, world!")
    if Log.isLogging(.debug) {
        Log.debug("This might be expensive \(arc4random_uniform(100))")
    }
    try response.end()
}

Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
