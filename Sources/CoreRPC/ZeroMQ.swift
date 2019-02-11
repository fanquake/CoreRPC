import Foundation
import PromiseKit

public extension CoreRPC {

    public struct ZMQNotification: Decodable {

        public enum Notification: String, Decodable {
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
