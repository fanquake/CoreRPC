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
            case ping
            case pong
            case sendcmpct
            case sendheaders
            case tx
            case verack
            case version
        }

        let addnode: Bool
        let addr: String
        let addrbind: String
        let addrlocal: String
        let banscore: Int
        let bytesrecv: Int
        //let bytesrecv_per_msg:
        let bytessent: Int
        //let bytessent_per_msg:
        let conntime: Int
        let id: Int
        let inbound: Bool
        let inflight: [Int]
        let lastrecv: Int
        let lastsend: Int
        let minfeefilter: Double
        let minping: Double
        let pingtime: Double
        let pingwait: Double?
        let relaytxes: Bool
        let services: String
        let servicesnames: [String]
        let startingheight: Int
        let subver: String
        let synced_blocks: Int
        let synced_headers: Int
        let timeoffset: Int
        let version: Int
        let whitelisted: Bool
    }
}
