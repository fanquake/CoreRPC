import Foundation
import PromiseKit

public extension CoreRPC {
    
    func getConnectionCount() -> Promise<Int> {
        return call(method: .getconnectioncount, params: Empty())
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
