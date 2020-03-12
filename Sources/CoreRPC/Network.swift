import Foundation
import PromiseKit

public extension CoreRPC {

    func getNetworkInfo() -> Promise<NetworkInfo> {
        return call(method: .getnetworkinfo, params: Empty())
    }
    
    struct Network: Codable {

        public enum Name: String, Codable {
            case ipv4
            case ipv6
            case onion
        }

        public let limited: Bool
        public let name: Name
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
        public let localaddresses: [NetworkAddress]
        public let localrelay: Bool
        public let localservices: String
        public let localservicesnames: [String]
        public let networkactive: Bool
        public let networks: [Network]
        public let protocolversion: Int
        public let relayfee: Double
        public let subversion: String
        public let timeoffset: Int
        public let version: Int
        public let warnings: String
    }

    func getNodeAddresses(count: Int? = 1) -> Promise<[NodeAddress]> {
        return call(method: .getnodeaddresses, params: [count])
    }

    struct NodeAddress: Codable {
        let address: String
        let port: Int
        let services: Int
        let time: Int
    }

    func getPeerInfo() -> Promise<[PeerInfo]> {
        return call(method: .getpeerinfo, params: Empty())
    }

    struct PeerInfo: Codable {

        enum MessageType: String, CodingKey, Codable {
            case addr
            case feefilter
            case getaddr
            case getdata
            case getheaders
            case headers
            case inv
            case other
            case ping
            case pong
            case sendcmpct
            case sendheaders
            case tx
            case verack
            case version
        }

        public struct PerMessage: Codable {
            public let addr: Int?
            public let block: Int?
            public let feefilter: Int?
            public let getheaders: Int?
            public let headers: Int?
            public let inv: Int?
            public let other: Int?
            public let ping: Int?
            public let pong: Int?
            public let sendcmpct: Int?
            public let sendheaders: Int?
            public let verack: Int?
            public let version: Int?
        }

        public let addnode: Bool
        public let addr: String
        public let addrbind: String
        public let addrlocal: String
        public let banscore: Int
        public let bytesrecv: Int
        public let bytesrecv_per_msg: PerMessage
        public let bytessent: Int
        public let bytessent_per_msg: PerMessage
        public let conntime: Int
        public let id: Int
        public let inbound: Bool
        public let inflight: [Int]
        public let lastrecv: Int
        public let lastsend: Int
        public let minfeefilter: Double
        public let minping: Double
        public let pingtime: Double
        public let pingwait: Double?
        public let relaytxes: Bool
        public let services: String
        public let servicesnames: [String]
        public let startingheight: Int
        public let subver: String
        public let synced_blocks: Int
        public let synced_headers: Int
        public let timeoffset: Int
        public let version: Int
        public let whitelisted: Bool
    }
}
