import Foundation
import Kitura
import Application

do {
    let app = try App()
    try app.run()
} catch let error {
    debugPrint(error.localizedDescription)
}
