import Foundation
import Kitura
import Application

do {
    let app = try App()
    try app.run()
} catch {
    debugPrint(error)
}
