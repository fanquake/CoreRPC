//
//  MemPool.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
    
    func getMemPoolInfo(completion: @escaping (RPCResult<MemPoolInfo>) -> Void) {
        call(method: .getmempoolinfo, params: nil) { result in
            completion(result.result!)
        }
    }
    
    struct MemPoolInfo: Codable {
        let bytes: Int
        let maxmempool: Int
        let mempoolminfee: Double
        let minrelaytxfee: Double
        let size: Int
        let usage: Int
    }
}
