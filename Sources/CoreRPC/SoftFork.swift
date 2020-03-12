import Foundation

public extension CoreRPC {

    // TODO: Make generic
    struct SoftForks: Codable {
        public let bip34: SoftFork
        public let bip65: SoftFork
        public let bip66: SoftFork
        public let csv: SoftFork
        public let segwit: SoftFork
    }
    
    struct SoftFork: Codable {

        public enum ForkType: String, Codable {
            case bip9
            case buried
        }

        public enum Status: String, Codable {
            case active
            case defined
            case failed
            case locked_in
            case started
        }

        public struct Statistics: Codable {
            public let count: Int
            public let elapsed: Int
            public let period: Int
            public let possible: Bool
            public let threshold: Int
        }

        public struct BIP9: Codable {
            public let bit: Int
            public let since: Int
            public let start_time: Int
            public let statistics: Statistics
            public let status: Status
            public let timeout: Int
        }

        public let active: Bool
        public let bip9: BIP9?
        public let height: Int
        public let type: ForkType
    }
}
