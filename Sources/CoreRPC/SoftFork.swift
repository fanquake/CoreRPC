import Foundation

public extension CoreRPC {
    
    struct SoftFork: Codable {

        public struct Status: Codable {
            public let status: Bool
        }

        public let id: String
        public let version: Int
        public let reject: Status
    }
    
    struct BIP9SoftFork: Codable {
        public let since: Int
        public let startTime: Int
        public let status: String
        public let timeout: Int
    }
}
