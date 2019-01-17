import Foundation
import PromiseKit

public extension CoreRPC {

    func generatetoaddress(blocks: Int, address: String, maxtries: Int?) -> Promise<[String]> {

        struct generateParams: Encodable {
            let nblocks: Int
            let address: String
            let maxtries: Int?
        }

        let params = generateParams(nblocks: blocks, address: address, maxtries: maxtries)

        return call(method: .generatetoaddress, params: params)
    }
    
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
