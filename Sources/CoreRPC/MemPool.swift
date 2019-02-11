import Foundation
import PromiseKit

public extension CoreRPC {
    
    func memPoolInfo() -> Promise<MemPoolInfo> {
        return call(method: .getmempoolinfo, params: Empty())
    }

    struct MemPoolInfo: Codable {
        public let bytes: Int
        public let maxmempool: Int
        public let mempoolminfee: Double
        public let minrelaytxfee: Double
        public let size: Int
        public let usage: Int
    }

    func getRawMempool() -> Promise<[String]> {
        return call(method: .getrawmempool, params: Empty())
    }
}
