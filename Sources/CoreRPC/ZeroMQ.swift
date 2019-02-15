import Foundation
import PromiseKit

public extension CoreRPC {

    public struct ZMQNotification: Codable {

        public enum Notification: String, Codable {
            case pubhashblock
            case pubhashtx
            case pubrawblock
            case pubrawtx
        }

        public let type: Notification
        public let address: URL
        public let hwm: Int
    }

    func getZMQNotifications() -> Promise<[ZMQNotification]> {
        return call(method: .getzmqnotifications, params: Empty())
    }
}
