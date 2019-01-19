import Foundation
import PromiseKit

public extension CoreRPC {

    struct RPCInfo: Decodable {

        struct ActiveCommand: Decodable {
            let duration: Int
            let method: RPCMethod
        }

        let active_commands: [ActiveCommand]
    }

    func getRPCInfo() -> Promise<RPCInfo> {

        return call(method: .getrpcinfo, params: Empty())
    }
    
    func getConnectionCount() -> Promise<Int> {
        return call(method: .getconnectioncount, params: Empty())
    }

    public enum LoggingCategory: String, Encodable {
        case addrman
        case bench
        case cmpctblock
        case coindb
        case db
        case estimatefee
        case http
        case leveldb
        case libevent
        case mempool
        case mempoolrej
        case net
        case proxy
        case prune
        case qt
        case rand
        case reindex
        case rpc
        case selectcoins
        case tor
        case zmq

        // special cases
        case all
        case none
        // Keeping these two special cases hidden as they are the same as above
        // case one = "1"
        // case zero = "0"
    }

    struct LoggingInfo: Decodable {
        public let addrman: Bool
        public let bench: Bool
        public let cmpctblock: Bool
        public let coindb: Bool
        public let db: Bool
        public let estimatefee: Bool
        public let http: Bool
        public let leveldb: Bool
        public let libevent: Bool
        public let mempool: Bool
        public let mempoolrej: Bool
        public let net: Bool
        public let proxy: Bool
        public let prune: Bool
        public let qt: Bool
        public let rand: Bool
        public let reindex: Bool
        public let rpc: Bool
        public let selectcoins: Bool
        public let tor: Bool
        public let zmq: Bool
    }

    func getLoggingInfo(include: [LoggingCategory]?, exclude: [LoggingCategory]?) -> Promise<LoggingInfo> {
        return call(method: .logging, params: [include, exclude])
    }

    public enum MemoryInfoMode: String, Encodable {
        case stats
        case mallocinfo
    }
    
    func getMemoryInfo(mode: MemoryInfoMode = .stats) -> Promise<MemoryInfo> {
        return call(method: .getmemoryinfo, params: [mode])
    }
    
    func getNetTotals() -> Promise<NetworkTraffic> {
        return call(method: .getnettotals, params: Empty())
    }
    
    func listBanned() -> Promise<[bannedNode]> {
        return call(method: .listbanned, params: Empty())
    }

    func uptime() -> Promise<Int> {
        return call(method: .uptime, params: Empty())
    }

    func help(command: String?) -> Promise<String> {
        return call(method: .help, params: [command])
    }
    
    struct bannedNode: Codable {
        public let address: String
        public let ban_created: Int
        public let ban_reason: String
        public let banned_util: Int
    }
    
    struct UploadTarget: Codable {
        public let bytes_left_in_cycle: Int
        public let target: Int
        public let target_reached: Bool
        public let timeframe: Int
        public let time_left_in_cycle: Int
        public let serve_historical_blocks: Bool
    }
    
    struct NetworkTraffic: Codable {
        public let totalbytesrecv: Int
        public let totalbytessent: Int
        public let timemillis: Int
        public let uploadtarget: UploadTarget
    }
    
    struct MemoryInfo: Decodable {
        public let locked: Locked
    }

    struct Locked: Decodable {
        public let chunks_free: Int
        public let chunks_used: Int
        public let free: Int
        public let locked: Int
        public let total: Int
        public let used: Int
    }
}
