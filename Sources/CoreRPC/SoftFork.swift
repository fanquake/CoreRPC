import Foundation

public extension CoreRPC {
    
    public struct SoftFork: Decodable {

        public struct Status: Decodable {
            public let status: Bool
        }

        public let id: String
        public let version: Int
        public let reject: Status
    }
    
    public struct BIP9SoftFork: Decodable {
        public let since: Int
        public let startTime: Int
        public let status: String
        public let timeout: Int
    }
}
