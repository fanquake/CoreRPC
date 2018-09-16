//
//  Mining.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
    
    func getMiningInfo(completion: @escaping (RPCResult<MiningInfo>) -> Void) {
        call(method: .getmininginfo, params: nil) { result in
            completion(result.result!)
        }
    }
    
    struct MiningInfo: Codable {
        let blocks: Int
        let chain: String
        let currentblocktx: Int
        let currentblockweight: Int
        let difficulty: Double
        let networkhashps: Double
        let pooledtx: Int
        let warnings: String
    }

}
