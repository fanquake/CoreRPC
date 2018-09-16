//
//  Mining.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
    
    func getMiningInfo(completion: @escaping (RPCResult<MiningInfo>) -> Void) {
        call(method: .getmininginfo, params: nil) { completion($0) }
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
