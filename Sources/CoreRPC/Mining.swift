import Foundation
import PromiseKit

public extension CoreRPC {
    
    func getMiningInfo() -> Promise<MiningInfo> {
        return call(method: .getmininginfo, params: Empty())
    }
    
    struct MiningInfo: Codable {
        public let blocks: Int
        public let chain: String
        public let currentblocktx: Int
        public let currentblockweight: Int
        public let difficulty: Double
        public let networkhashps: Double
        public let pooledtx: Int
        public let warnings: String
    }
    
}
