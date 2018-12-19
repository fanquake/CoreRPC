import Foundation
import PromiseKit

public extension CoreRPC {
    func getNetworkInfo() -> Promise<NetworkInfo> {
        return call(method: .getnetworkinfo, params: Empty())
    }
    
    struct Network: Codable {
        public let limited: Bool
        public let name: String
        public let proxy: String
        public let proxy_randomize_credentials: Bool
        public let reachable: Bool
    }
    
    struct NetworkAddress: Codable {
        public let address: String
        public let port: Int
        public let score: Int
    }
    
    struct NetworkInfo: Codable {
        public let connections: Int
        public let incrementalfee: Double
        public let localaddresses: Array<NetworkAddress>
        public let networkactive: Bool
        public let networks: Array<Network>
        public let localrelay: Bool
        public let localservices: String
        public let protocolversion: Int
        public let relayfee: Double
        public let subversion: String
        public let timeoffset: Int
        public let version: Int
        public let warnings: String
    }
}
